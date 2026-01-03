import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';
import 'month_generator.dart';

class SyncResult {
  final bool ok;
  final String message;
  const SyncResult(this.ok, this.message);
}

class SyncService {
  final AppDatabase db;
  final SyncSetting settings;
  SyncService(this.db, this.settings);

  void _log(String msg) {
    debugPrint('[SyncService] $msg');
  }

  DateTime? _parseDate(dynamic value, [DateTime? fallback]) {
    if (value == null) return fallback;
    if (value is num) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt());
    }
    if (value is String && value.isNotEmpty) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
    }
    return fallback;
  }

  bool _asBool(dynamic v, {bool fallback = true}) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    return fallback;
  }

  bool get isRemoteEnabled =>
      settings.useRemote &&
      (settings.baseUrl?.isNotEmpty ?? false) &&
      (settings.apiKey?.isNotEmpty ?? false);

  Uri? _resolve(String path, [Map<String, String>? query]) {
    if (!isRemoteEnabled) return null;
    try {
      return Uri.parse(settings.baseUrl!)
          .resolve(path)
          .replace(queryParameters: query);
    } catch (_) {
      return null;
    }
  }

  Future<SyncResult> testConnection() async {
    _log('Testing connection');
    final uri = _resolve('/health');
    if (uri == null) {
      return const SyncResult(false, 'Remote sync disabled or invalid URL');
    }
    try {
      final resp = await http.get(uri, headers: {
        'x-api-key': settings.apiKey ?? ''
      }).timeout(const Duration(seconds: 8));
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        _log('Health OK');
        return const SyncResult(true, 'Connection OK');
      }
      _log('Health failed: ${resp.statusCode}');
      return SyncResult(false, 'Server responded ${resp.statusCode}');
    } catch (e) {
      _log('Health error: $e');
      return SyncResult(false, 'Failed: $e');
    }
  }

  Future<SyncResult> syncNow() async {
    _log('Sync start');
    try {
      if (db.profile != 'remote') {
        return const SyncResult(false, 'Sync only runs on the remote profile');
      }
      if (!isRemoteEnabled) {
        return const SyncResult(false, 'Remote sync disabled');
      }
      final health = await testConnection();
      if (!health.ok) return health;

      final deviceId = await db.ensureDeviceId(settings.deviceId);
      await db.ensureRemoteIdsForAll();

      // Pre-pull to align IDs before pushing (fixes missing refs)
      final prePullUri = _resolve('/api/v1/sync/changes',
          {'since': settings.lastSyncServerMs?.toString() ?? '0'});
      if (prePullUri == null) return const SyncResult(false, 'Invalid URL');
      final prePullResp = await http.get(prePullUri, headers: {
        'x-api-key': settings.apiKey ?? ''
      }).timeout(const Duration(seconds: 15));
      _log('Pre-pull status: ${prePullResp.statusCode}');
      if (prePullResp.statusCode >= 200 && prePullResp.statusCode < 300) {
        final body = jsonDecode(prePullResp.body) as Map<String, dynamic>;
        final changes = body['changes'] as Map<String, dynamic>? ?? {};
        await _applyChanges(changes);
      }

      final outbox = await db.getOutboxBatch(limit: 200);
      _log('Outbox size: ${outbox.length}');
      final upserts = await _buildLocalUpserts();
      final deletes = _buildDeletes(outbox);
      // Bootstrap references first (categories, templates) to avoid FK errors on instances
      final bootstrapUpserts = {
        'categories': upserts['categories'] ?? [],
        'bill_templates': upserts['bill_templates'] ?? [],
      };

      final pushUri = _resolve('/api/v1/sync/push');
      if (pushUri == null) return const SyncResult(false, 'Invalid URL');

      // Send bootstrap push if needed
      if ((bootstrapUpserts['categories'] as List).isNotEmpty ||
          (bootstrapUpserts['bill_templates'] as List).isNotEmpty) {
        final bootstrapResp = await http
            .post(
              pushUri,
              headers: {
                'x-api-key': settings.apiKey ?? '',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'device_id': deviceId,
                'client_now': DateTime.now().millisecondsSinceEpoch,
                'upserts': bootstrapUpserts,
                'deletes': {},
              }),
            )
            .timeout(const Duration(seconds: 15));
        _log('Bootstrap push status: ${bootstrapResp.statusCode}');
        if (bootstrapResp.statusCode < 200 || bootstrapResp.statusCode >= 300) {
          return SyncResult(false,
              'Push failed ${bootstrapResp.statusCode}: ${bootstrapResp.body}');
        }
      }

      final pushResp = await http
          .post(
            pushUri,
            headers: {
              'x-api-key': settings.apiKey ?? '',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'device_id': deviceId,
              'client_now': DateTime.now().millisecondsSinceEpoch,
              'upserts': upserts,
              'deletes': deletes,
            }),
          )
          .timeout(const Duration(seconds: 15));
      _log('Push status: ${pushResp.statusCode}');
      if (pushResp.statusCode < 200 || pushResp.statusCode >= 300) {
        return SyncResult(
            false, 'Push failed ${pushResp.statusCode}: ${pushResp.body}');
      }
      await db.clearOutboxIds(outbox.map((e) => e.id).toList());

      final pullUri = _resolve('/api/v1/sync/changes', {
        'since': settings.lastSyncServerMs?.toString() ?? '0',
      });
      if (pullUri == null) return const SyncResult(false, 'Invalid URL');

      final pullResp = await http.get(pullUri, headers: {
        'x-api-key': settings.apiKey ?? ''
      }).timeout(const Duration(seconds: 20));
      _log('Pull status: ${pullResp.statusCode}');
      if (pullResp.statusCode < 200 || pullResp.statusCode >= 300) {
        return SyncResult(
            false, 'Pull failed ${pullResp.statusCode}: ${pullResp.body}');
      }
      final body = jsonDecode(pullResp.body) as Map<String, dynamic>;
      final serverNow =
          body['server_now'] as int? ?? DateTime.now().millisecondsSinceEpoch;
      final changes = body['changes'] as Map<String, dynamic>? ?? {};
      await _applyChanges(changes);
      // Generate near-term months so new templates/sources create instances locally
      await MonthGenerator(db).ensureCurrentAndNextMonthGenerated();
      await db.saveSyncSettings(
        useRemote: settings.useRemote,
        mode: settings.mode,
        baseUrl: settings.baseUrl,
        apiKey: settings.apiKey,
        deviceId: deviceId,
        lastSyncServerMs: serverNow,
      );

      // Auto-push again if anything new was queued during this sync
      final remainingOutbox = await db.getOutboxBatch(limit: 200);
      if (remainingOutbox.isNotEmpty) {
        _log(
            'Outbox after pull: ${remainingOutbox.length}, pushing automatically');
        final upserts2 = await _buildLocalUpserts();
        final deletes2 = _buildDeletes(remainingOutbox);
        final pushResp2 = await http
            .post(
              pushUri,
              headers: {
                'x-api-key': settings.apiKey ?? '',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'device_id': deviceId,
                'client_now': DateTime.now().millisecondsSinceEpoch,
                'upserts': upserts2,
                'deletes': deletes2,
              }),
            )
            .timeout(const Duration(seconds: 15));
        _log('Post-pull push status: ${pushResp2.statusCode}');
        if (pushResp2.statusCode >= 200 && pushResp2.statusCode < 300) {
          await db.clearOutboxIds(remainingOutbox.map((e) => e.id).toList());
        } else {
          return SyncResult(false,
              'Push failed after pull ${pushResp2.statusCode}: ${pushResp2.body}');
        }
      }

      _log('Sync complete');
      return const SyncResult(true, 'Sync complete');
    } catch (e) {
      _log('Sync error: $e');
      return SyncResult(false, 'Sync error: $e');
    }
  }

  Map<String, dynamic> _buildDeletes(List<OutboxEntry> outbox) {
    Map<String, List<Map<String, String>>> grouped = {};
    for (final entry in outbox.where((e) => e.op == 'delete')) {
      grouped
          .putIfAbsent(entry.entityType, () => [])
          .add({'id': entry.entityId});
    }
    return grouped.map((k, v) => MapEntry(k, v));
  }

  Future<Map<String, dynamic>> _buildLocalUpserts() async {
    final categoriesRows = await (db.select(db.categories)
          ..where((c) => c.profileId.equals(db.profile)))
        .get();
    final categoryRemoteSet = {
      for (final c in categoriesRows)
        if (c.remoteId != null) c.remoteId!
    };
    final categoryByName = {for (final c in categoriesRows) c.name: c};
    final catPayload = categoriesRows.map((c) {
      return {
        'id': c.remoteId ?? const Uuid().v4(),
        'name': c.name,
        'color': c.color,
        'icon': c.icon,
        'sort_order': c.sortOrder,
        'device_id': c.deviceId,
        'client_updated_at': DateTime.now().millisecondsSinceEpoch,
      };
    }).toList();

    final templatesRows = await (db.select(db.billTemplates)
          ..where((t) => t.profileId.equals(db.profile)))
        .get();
    final templatePayload = templatesRows.map((t) {
      String? categoryRemote = t.categoryRemoteId;
      if (categoryRemote == null ||
          !categoryRemoteSet.contains(categoryRemote)) {
        categoryRemote = t.category != null
            ? categoryByName[t.category!]?.remoteId
            : categoryRemote;
      }
      return {
        'id': t.remoteId ?? const Uuid().v4(),
        'name': t.name,
        'category_id': categoryRemote,
        'default_amount_cents': t.defaultAmountCents,
        'start_date': t.startDate,
        'active': t.active,
        'recurrence_rule': t.recurrenceRule,
        'created_at': t.createdAt.toIso8601String(),
        'device_id': t.deviceId,
        'client_updated_at': DateTime.now().millisecondsSinceEpoch,
      };
    }).toList();

    final templateById = {for (final t in templatesRows) t.id: t};
    final instancesRows = await (db.select(db.billInstances)
          ..where((i) => i.profileId.equals(db.profile)))
        .get();
    final instancesPayload = instancesRows.map((i) {
      final templateRemote =
          i.templateRemoteId ?? templateById[i.templateId]?.remoteId;
      String? categoryRemote = i.categoryRemoteId;
      if (categoryRemote == null ||
          !categoryRemoteSet.contains(categoryRemote)) {
        categoryRemote = i.category != null
            ? categoryByName[i.category!]?.remoteId
            : categoryRemote;
      }
      return {
        'id': i.remoteId ?? const Uuid().v4(),
        'template_id': templateRemote,
        'title_snapshot': i.titleSnapshot,
        'amount_cents': i.amountCents,
        'due_date': i.dueDate,
        'status': i.status,
        'paid_amount_cents': i.paidAmountCents,
        'paid_at': i.paidAt?.toIso8601String(),
        'notes': i.notes,
        'category_id': categoryRemote,
        'created_at': i.createdAt.toIso8601String(),
        'device_id': i.deviceId,
        'client_updated_at': DateTime.now().millisecondsSinceEpoch,
      };
    }).toList();

    final incomeSourcesRows = await (db.select(db.incomeSources)
          ..where((s) => s.profileId.equals(db.profile)))
        .get();
    final incomeSourcesPayload = incomeSourcesRows.map((s) {
      return {
        'id': s.remoteId ?? const Uuid().v4(),
        'name': s.name,
        'amount_cents': s.amountCents,
        'frequency': s.frequency,
        'start_date': s.startDate,
        'anchor_date': s.anchorDate,
        'active': s.active,
        'created_at': s.createdAt.toIso8601String(),
        'device_id': s.deviceId,
        'client_updated_at': DateTime.now().millisecondsSinceEpoch,
      };
    }).toList();

    final incomeSourcesById = {for (final s in incomeSourcesRows) s.id: s};
    final incomeInstancesRows = await (db.select(db.incomeInstances)
          ..where((i) => i.profileId.equals(db.profile)))
        .get();
    final incomeInstancesPayload = incomeInstancesRows.map((i) {
      final sourceRemote =
          i.sourceRemoteId ?? incomeSourcesById[i.sourceId]?.remoteId;
      return {
        'id': i.remoteId ?? const Uuid().v4(),
        'source_id': sourceRemote,
        'title_snapshot': i.titleSnapshot,
        'amount_cents': i.amountCents,
        'date': i.date,
        'status': i.status,
        'received_at': i.receivedAt?.toIso8601String(),
        'notes': i.notes,
        'created_at': i.createdAt.toIso8601String(),
        'device_id': i.deviceId,
        'client_updated_at': DateTime.now().millisecondsSinceEpoch,
      };
    }).toList();

    return {
      'categories': catPayload,
      'bill_templates': templatePayload,
      'bill_instances': instancesPayload,
      'income_sources': incomeSourcesPayload,
      'income_instances': incomeInstancesPayload,
    };
  }

  Future<void> _applyChanges(Map<String, dynamic> changes) async {
    final serverCategories = (changes['categories'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final serverTemplates = (changes['bill_templates'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final serverInstances = (changes['bill_instances'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final serverIncomeSources =
        (changes['income_sources'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>();
    final serverIncomeInstances =
        (changes['income_instances'] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>();

    await db.transaction(() async {
      for (final c in serverCategories) {
        final remoteId = c['id'] as String?;
        if (remoteId == null) continue;
        if (c['deleted_at_server'] != null) {
          await (db.delete(db.categories)
                ..where((t) =>
                    t.profileId.equals(db.profile) &
                    t.remoteId.equals(remoteId)))
              .go();
          continue;
        }
        final name = c['name'] as String? ?? 'Category';
        Category? existingByName = await (db.select(db.categories)
              ..where((t) =>
                  t.profileId.equals(db.profile) & t.remoteId.equals(remoteId)))
            .getSingleOrNull();
        // Fallback: match by name to avoid UNIQUE(name) collisions when remote_id is new
        existingByName ??= await (db.select(db.categories)
              ..where(
                  (t) => t.profileId.equals(db.profile) & t.name.equals(name)))
            .getSingleOrNull();
        final companion = CategoriesCompanion(
          profileId: Value(db.profile),
          remoteId: Value(remoteId),
          householdId: Value(c['household_id'] as String?),
          name: Value(name),
          color: Value(c['color'] as String?),
          icon: Value(c['icon'] as String?),
          sortOrder: Value((c['sort_order'] as num?)?.toInt() ?? 0),
          updatedAtServer: Value((c['updated_at_server'] as num?)?.toInt()),
          deletedAtServer: Value((c['deleted_at_server'] as num?)?.toInt()),
          deviceId: Value(c['device_id'] as String?),
          clientUpdatedAt: Value((c['client_updated_at'] as num?)?.toInt()),
        );
        if (existingByName == null) {
          await db.into(db.categories).insert(companion);
        } else {
          final existing = existingByName;
          await (db.update(db.categories)
                ..where((t) => t.id.equals(existing.id)))
              .write(companion);
        }
      }

      for (final t in serverTemplates) {
        final remoteId = t['id'] as String?;
        if (remoteId == null) continue;
        if (t['deleted_at_server'] != null) {
          await (db.delete(db.billTemplates)
                ..where((b) =>
                    b.profileId.equals(db.profile) &
                    b.remoteId.equals(remoteId)))
              .go();
          continue;
        }
        final existing = await (db.select(db.billTemplates)
              ..where((b) =>
                  b.profileId.equals(db.profile) & b.remoteId.equals(remoteId)))
            .getSingleOrNull();
        final categoryRemote = t['category_id'] as String?;
        final categoryName = categoryRemote == null
            ? null
            : (await (db.select(db.categories)
                      ..where((c) =>
                          c.profileId.equals(db.profile) &
                          c.remoteId.equals(categoryRemote)))
                    .getSingleOrNull())
                ?.name;
        final recurrenceRule =
            t['recurrence_rule'] as String? ?? existing?.recurrenceRule;
        final active = _asBool(t['active'], fallback: existing?.active ?? true);
        final createdAt =
            _parseDate(t['created_at'], existing?.createdAt ?? DateTime.now());
        final companion = BillTemplatesCompanion(
          profileId: Value(db.profile),
          remoteId: Value(remoteId),
          householdId: Value(t['household_id'] as String?),
          name: Value(t['name'] as String? ?? 'Template'),
          categoryRemoteId: Value(categoryRemote),
          category: Value(categoryName),
          defaultAmountCents:
              Value((t['default_amount_cents'] as num?)?.toInt() ?? 0),
          startDate: Value(t['start_date'] as String? ?? existing?.startDate),
          active: Value(active),
          recurrenceRule: Value(recurrenceRule),
          createdAt: Value(createdAt ?? DateTime.now()),
          updatedAtServer: Value((t['updated_at_server'] as num?)?.toInt()),
          deletedAtServer: Value((t['deleted_at_server'] as num?)?.toInt()),
          deviceId: Value(t['device_id'] as String?),
          clientUpdatedAt: Value((t['client_updated_at'] as num?)?.toInt()),
        );
        if (existing == null) {
          await db.into(db.billTemplates).insert(companion);
        } else {
          await (db.update(db.billTemplates)
                ..where((b) => b.remoteId.equals(remoteId)))
              .write(companion);
        }
      }

      for (final i in serverInstances) {
        final remoteId = i['id'] as String?;
        if (remoteId == null) continue;
        if (i['deleted_at_server'] != null) {
          await (db.delete(db.billInstances)
                ..where((b) =>
                    b.profileId.equals(db.profile) &
                    b.remoteId.equals(remoteId)))
              .go();
          continue;
        }
        final existing = await (db.select(db.billInstances)
              ..where((b) =>
                  b.profileId.equals(db.profile) & b.remoteId.equals(remoteId)))
            .getSingleOrNull();
        final templateRemote = i['template_id'] as String?;
        final templateRow = templateRemote == null
            ? null
            : await (db.select(db.billTemplates)
                  ..where((t) =>
                      t.profileId.equals(db.profile) &
                      t.remoteId.equals(templateRemote)))
                .getSingleOrNull();
        final categoryRemote = i['category_id'] as String?;
        final categoryName = categoryRemote == null
            ? null
            : (await (db.select(db.categories)
                      ..where((c) =>
                          c.profileId.equals(db.profile) &
                          c.remoteId.equals(categoryRemote)))
                    .getSingleOrNull())
                ?.name;

        final status =
            i['status'] as String? ?? existing?.status ?? 'scheduled';
        final createdAt =
            _parseDate(i['created_at'], existing?.createdAt ?? DateTime.now());
        final companion = BillInstancesCompanion(
          profileId: Value(db.profile),
          remoteId: Value(remoteId),
          householdId: Value(i['household_id'] as String?),
          templateId: Value(templateRow?.id),
          templateRemoteId: Value(templateRemote),
          titleSnapshot: Value(i['title_snapshot'] as String? ?? 'Bill'),
          amountCents: Value((i['amount_cents'] as num?)?.toInt() ?? 0),
          dueDate: Value(i['due_date'] as String? ?? ''),
          status: Value(status),
          paidAmountCents: Value((i['paid_amount_cents'] as num?)?.toInt()),
          paidAt: Value(_parseDate(i['paid_at'], existing?.paidAt)),
          notes: Value(i['notes'] as String?),
          category: Value(categoryName),
          categoryRemoteId: Value(categoryRemote),
          createdAt: Value(createdAt ?? DateTime.now()),
          updatedAtServer: Value((i['updated_at_server'] as num?)?.toInt()),
          deletedAtServer: Value((i['deleted_at_server'] as num?)?.toInt()),
          deviceId: Value(i['device_id'] as String?),
          clientUpdatedAt: Value((i['client_updated_at'] as num?)?.toInt()),
        );
        if (existing == null) {
          await db.into(db.billInstances).insert(companion);
        } else {
          await (db.update(db.billInstances)
                ..where((b) => b.remoteId.equals(remoteId)))
              .write(companion);
        }
      }

      for (final s in serverIncomeSources) {
        final remoteId = s['id'] as String?;
        if (remoteId == null) continue;
        if (s['deleted_at_server'] != null) {
          await (db.delete(db.incomeSources)
                ..where((b) =>
                    b.profileId.equals(db.profile) &
                    b.remoteId.equals(remoteId)))
              .go();
          continue;
        }
        final existing = await (db.select(db.incomeSources)
              ..where((b) =>
                  b.profileId.equals(db.profile) & b.remoteId.equals(remoteId)))
            .getSingleOrNull();
        final companion = IncomeSourcesCompanion(
          profileId: Value(db.profile),
          remoteId: Value(remoteId),
          householdId: Value(s['household_id'] as String?),
          name: Value(s['name'] as String? ?? 'Income'),
          amountCents: Value((s['amount_cents'] as num?)?.toInt() ?? 0),
          frequency: Value(s['frequency'] as String? ?? 'monthly'),
          startDate: Value(s['start_date'] as String?),
          anchorDate: Value(s['anchor_date'] as String?),
          active:
              Value(_asBool(s['active'], fallback: existing?.active ?? true)),
          createdAt: Value(_parseDate(
                  s['created_at'], existing?.createdAt ?? DateTime.now()) ??
              DateTime.now()),
          updatedAtServer: Value((s['updated_at_server'] as num?)?.toInt()),
          deletedAtServer: Value((s['deleted_at_server'] as num?)?.toInt()),
          deviceId: Value(s['device_id'] as String?),
          clientUpdatedAt: Value((s['client_updated_at'] as num?)?.toInt()),
        );
        if (existing == null) {
          await db.into(db.incomeSources).insert(companion);
        } else {
          await (db.update(db.incomeSources)
                ..where((b) => b.remoteId.equals(remoteId)))
              .write(companion);
        }
      }

      for (final i in serverIncomeInstances) {
        final remoteId = i['id'] as String?;
        if (remoteId == null) continue;
        if (i['deleted_at_server'] != null) {
          await (db.delete(db.incomeInstances)
                ..where((b) =>
                    b.profileId.equals(db.profile) &
                    b.remoteId.equals(remoteId)))
              .go();
          continue;
        }
        final sourceRemote = i['source_id'] as String?;
        final sourceRow = sourceRemote == null
            ? null
            : await (db.select(db.incomeSources)
                  ..where((t) =>
                      t.profileId.equals(db.profile) &
                      t.remoteId.equals(sourceRemote)))
                .getSingleOrNull();

        final existing = await (db.select(db.incomeInstances)
              ..where((b) =>
                  b.profileId.equals(db.profile) & b.remoteId.equals(remoteId)))
            .getSingleOrNull();
        final companion = IncomeInstancesCompanion(
          profileId: Value(db.profile),
          remoteId: Value(remoteId),
          householdId: Value(i['household_id'] as String?),
          sourceId: Value(sourceRow?.id),
          sourceRemoteId: Value(sourceRemote),
          titleSnapshot: Value(i['title_snapshot'] as String? ?? 'Income'),
          amountCents: Value((i['amount_cents'] as num?)?.toInt() ?? 0),
          date: Value(i['date'] as String? ?? ''),
          status: Value(i['status'] as String? ?? 'expected'),
          receivedAt: Value(_parseDate(i['received_at'], existing?.receivedAt)),
          notes: Value(i['notes'] as String?),
          createdAt: Value(_parseDate(
                  i['created_at'], existing?.createdAt ?? DateTime.now()) ??
              DateTime.now()),
          updatedAtServer: Value((i['updated_at_server'] as num?)?.toInt()),
          deletedAtServer: Value((i['deleted_at_server'] as num?)?.toInt()),
          deviceId: Value(i['device_id'] as String?),
          clientUpdatedAt: Value((i['client_updated_at'] as num?)?.toInt()),
        );
        if (existing == null) {
          await db.into(db.incomeInstances).insert(companion);
        } else {
          await (db.update(db.incomeInstances)
                ..where((b) => b.remoteId.equals(remoteId)))
              .write(companion);
        }
      }
    });
  }
}
