import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class BillTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get householdId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get categoryRemoteId => text().nullable()();
  IntColumn get defaultAmountCents => integer()();
  TextColumn get startDate => text().nullable()(); // YYYY-MM-DD
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  /// JSON string, e.g. {"type":"monthly","day":1}
  TextColumn get recurrenceRule => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get updatedAtServer => integer().nullable()();
  IntColumn get deletedAtServer => integer().nullable()();
  TextColumn get deviceId => text().nullable()();
  IntColumn get clientUpdatedAt => integer().nullable()();
}

class BillInstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get householdId => text().nullable()();
  IntColumn get templateId => integer().nullable()(); // null for one-time
  TextColumn get templateRemoteId => text().nullable()();
  TextColumn get titleSnapshot => text()();
  IntColumn get amountCents => integer()();
  TextColumn get dueDate => text()(); // YYYY-MM-DD
  TextColumn get status => text().withDefault(const Constant('scheduled'))(); // scheduled|paid|skipped|partial
  IntColumn get paidAmountCents => integer().nullable()();
  DateTimeColumn get paidAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get categoryRemoteId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get updatedAtServer => integer().nullable()();
  IntColumn get deletedAtServer => integer().nullable()();
  TextColumn get deviceId => text().nullable()();
  IntColumn get clientUpdatedAt => integer().nullable()();
}

class IncomeSources extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get householdId => text().nullable()();
  TextColumn get name => text()();
  IntColumn get amountCents => integer()();
  TextColumn get frequency => text()(); // monthly|weekly|biweekly|one_time|yearly
  TextColumn get startDate => text().nullable()(); // YYYY-MM-DD
  TextColumn get anchorDate => text().nullable()(); // YYYY-MM-DD
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get updatedAtServer => integer().nullable()();
  IntColumn get deletedAtServer => integer().nullable()();
  TextColumn get deviceId => text().nullable()();
  IntColumn get clientUpdatedAt => integer().nullable()();
}

class IncomeInstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get householdId => text().nullable()();
  IntColumn get sourceId => integer().nullable()(); // null for one-time
  TextColumn get sourceRemoteId => text().nullable()();
  TextColumn get titleSnapshot => text()();
  IntColumn get amountCents => integer()();
  TextColumn get date => text()(); // YYYY-MM-DD
  TextColumn get status => text().withDefault(const Constant('expected'))(); // expected|received|skipped
  DateTimeColumn get receivedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get updatedAtServer => integer().nullable()();
  IntColumn get deletedAtServer => integer().nullable()();
  TextColumn get deviceId => text().nullable()();
  IntColumn get clientUpdatedAt => integer().nullable()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get householdId => text().nullable()();
  TextColumn get name => text().unique()();
  TextColumn get color => text().nullable()(); // Hex color code
  TextColumn get icon => text().nullable()(); // Icon name
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get updatedAtServer => integer().nullable()();
  IntColumn get deletedAtServer => integer().nullable()();
  TextColumn get deviceId => text().nullable()();
  IntColumn get clientUpdatedAt => integer().nullable()();
}

class SyncSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  BoolColumn get useRemote => boolean().withDefault(const Constant(false))();
  TextColumn get baseUrl => text().nullable()();
  TextColumn get apiKey => text().nullable()();
  TextColumn get mode => text().withDefault(const Constant('local_only'))(); // local_only | hybrid
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get lastSyncServerMs => integer().withDefault(const Constant(0))();
  TextColumn get deviceId => text().nullable()();
}

class OutboxEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().withDefault(const Constant('remote'))();
  TextColumn get entityType => text()(); // categories|bill_templates|...
  TextColumn get entityId => text()(); // remote UUID
  TextColumn get op => text()(); // upsert|delete
  TextColumn get payloadJson => text().nullable()();
  DateTimeColumn get queuedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [BillTemplates, BillInstances, IncomeSources, IncomeInstances, Categories, SyncSettings, OutboxEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  String activeProfileId = 'remote';
  void setActiveProfile(String profileId) {
    activeProfileId = profileId;
  }
  String get profile => activeProfileId;

  static Future<AppDatabase> open() async {
    if (kIsWeb) {
      final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sql-wasm.wasm'));
      return AppDatabase(
        WasmDatabase(
          sqlite3: sqlite3,
          path: 'budget_calendar',
        ),
      );
    }

    final executor = driftDatabase(
      name: 'budget_calendar.db',
      native: const DriftNativeOptions(),
    );

    final db = AppDatabase(executor);
    await db.customStatement("PRAGMA foreign_keys = ON;");
    return db;
  }

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedCategories(profileId: 'remote');
      await into(syncSettings).insert(
        SyncSettingsCompanion(
          useRemote: const Value(false),
          mode: const Value('local_only'),
        ),
      );
      await _createRemoteIdIndexes(m);
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(billTemplates, billTemplates.startDate);
        await m.addColumn(incomeSources, incomeSources.startDate);
      }
      if (from < 3) {
        await m.createTable(syncSettings);
        await into(syncSettings).insert(
          SyncSettingsCompanion(
            useRemote: const Value(false),
            mode: const Value('local_only'),
          ),
        );
      }
      if (from < 4) {
        await m.createTable(outboxEntries);
        await m.addColumn(categories, categories.remoteId);
        await m.addColumn(categories, categories.householdId);
        await m.addColumn(categories, categories.updatedAtServer);
        await m.addColumn(categories, categories.deletedAtServer);
        await m.addColumn(categories, categories.deviceId);
        await m.addColumn(categories, categories.clientUpdatedAt);

        await m.addColumn(billTemplates, billTemplates.remoteId);
        await m.addColumn(billTemplates, billTemplates.householdId);
        await m.addColumn(billTemplates, billTemplates.categoryRemoteId);
        await m.addColumn(billTemplates, billTemplates.updatedAtServer);
        await m.addColumn(billTemplates, billTemplates.deletedAtServer);
        await m.addColumn(billTemplates, billTemplates.deviceId);
        await m.addColumn(billTemplates, billTemplates.clientUpdatedAt);

        await m.addColumn(billInstances, billInstances.remoteId);
        await m.addColumn(billInstances, billInstances.householdId);
        await m.addColumn(billInstances, billInstances.templateRemoteId);
        await m.addColumn(billInstances, billInstances.categoryRemoteId);
        await m.addColumn(billInstances, billInstances.updatedAtServer);
        await m.addColumn(billInstances, billInstances.deletedAtServer);
        await m.addColumn(billInstances, billInstances.deviceId);
        await m.addColumn(billInstances, billInstances.clientUpdatedAt);

        await m.addColumn(incomeSources, incomeSources.remoteId);
        await m.addColumn(incomeSources, incomeSources.householdId);
        await m.addColumn(incomeSources, incomeSources.updatedAtServer);
        await m.addColumn(incomeSources, incomeSources.deletedAtServer);
        await m.addColumn(incomeSources, incomeSources.deviceId);
        await m.addColumn(incomeSources, incomeSources.clientUpdatedAt);

        await m.addColumn(incomeInstances, incomeInstances.remoteId);
        await m.addColumn(incomeInstances, incomeInstances.householdId);
        await m.addColumn(incomeInstances, incomeInstances.sourceRemoteId);
        await m.addColumn(incomeInstances, incomeInstances.updatedAtServer);
        await m.addColumn(incomeInstances, incomeInstances.deletedAtServer);
        await m.addColumn(incomeInstances, incomeInstances.deviceId);
        await m.addColumn(incomeInstances, incomeInstances.clientUpdatedAt);

        await m.addColumn(syncSettings, syncSettings.lastSyncServerMs);
        await m.addColumn(syncSettings, syncSettings.deviceId);

        // Backfill remote IDs for existing rows.
        await ensureRemoteIdsForAll();
        await _createRemoteIdIndexes(m);
      }
      if (from < 5) {
        await m.addColumn(categories, categories.profileId);
        await m.addColumn(billTemplates, billTemplates.profileId);
        await m.addColumn(billInstances, billInstances.profileId);
        await m.addColumn(incomeSources, incomeSources.profileId);
        await m.addColumn(incomeInstances, incomeInstances.profileId);
        await m.addColumn(syncSettings, syncSettings.profileId);
        await m.addColumn(outboxEntries, outboxEntries.profileId);
        // Set existing rows to remote profile
        await customStatement("UPDATE categories SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await customStatement("UPDATE bill_templates SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await customStatement("UPDATE bill_instances SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await customStatement("UPDATE income_sources SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await customStatement("UPDATE income_instances SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await customStatement("UPDATE sync_settings SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await customStatement("UPDATE outbox_entries SET profile_id = 'remote' WHERE profile_id IS NULL;");
        await _createRemoteIdIndexes(m);
      }
    },
  );

  Future<void> _seedCategories({String? profileId}) async {
    final pid = profileId ?? profile;
    Future<int> insert(String name, String color, int sortOrder, String remoteId) {
      return into(categories).insert(
        CategoriesCompanion.insert(
          profileId: Value(pid),
          name: name,
          color: Value(color),
          sortOrder: Value(sortOrder),
          remoteId: Value(remoteId),
        ),
      );
    }

    await insert('Housing', '#4CAF50', 1, 'seed-housing');
    await insert('Utilities', '#2196F3', 2, 'seed-utilities');
    await insert('Transportation', '#FF9800', 3, 'seed-transport');
    await insert('Insurance', '#9C27B0', 4, 'seed-insurance');
    await insert('Subscriptions', '#E91E63', 5, 'seed-subs');
    await insert('Food', '#795548', 6, 'seed-food');
    await insert('Healthcare', '#00BCD4', 7, 'seed-health');
    await insert('Other', '#607D8B', 99, 'seed-other');
  }

  Future<void> clearAllData() async {
    final settings = await ensureSyncSettingsRow();
    await transaction(() async {
      await (delete(outboxEntries)..where((o) => o.profileId.equals(profile))).go();
      await (delete(billInstances)..where((b) => b.profileId.equals(profile))).go();
      await (delete(billTemplates)..where((b) => b.profileId.equals(profile))).go();
      await (delete(incomeInstances)..where((i) => i.profileId.equals(profile))).go();
      await (delete(incomeSources)..where((i) => i.profileId.equals(profile))).go();
      await (delete(categories)..where((c) => c.profileId.equals(profile))).go();

      await _seedCategories();
      await ensureRemoteIdsForAll();
      await saveSyncSettings(
        useRemote: settings.useRemote,
        mode: settings.mode,
        baseUrl: settings.baseUrl,
        apiKey: settings.apiKey,
        deviceId: settings.deviceId,
        lastSyncServerMs: 0,
      );
    });
  }

  // ------------ Sync helpers ------------

  Future<String> _ensureRemoteId(String? existing) async {
    return existing ?? const Uuid().v4();
  }

  Future<void> ensureRemoteIdsForAll() async {
    await transaction(() async {
      final catRows = await (select(categories)..where((c) => c.profileId.equals(profile) & c.remoteId.isNull())).get();
      for (final c in catRows) {
        final id = await _ensureRemoteId(c.remoteId);
        await (update(categories)..where((t) => t.id.equals(c.id))).write(CategoriesCompanion(remoteId: Value(id)));
      }

      final btRows = await (select(billTemplates)..where((t) => t.profileId.equals(profile) & t.remoteId.isNull())).get();
      for (final t in btRows) {
        final id = await _ensureRemoteId(t.remoteId);
        await (update(billTemplates)..where((b) => b.id.equals(t.id))).write(BillTemplatesCompanion(remoteId: Value(id)));
      }

      final biRows = await (select(billInstances)..where((t) => t.profileId.equals(profile) & t.remoteId.isNull())).get();
      for (final t in biRows) {
        final id = await _ensureRemoteId(t.remoteId);
        await (update(billInstances)..where((b) => b.id.equals(t.id))).write(BillInstancesCompanion(remoteId: Value(id)));
      }

      final isRows = await (select(incomeSources)..where((t) => t.profileId.equals(profile) & t.remoteId.isNull())).get();
      for (final t in isRows) {
        final id = await _ensureRemoteId(t.remoteId);
        await (update(incomeSources)..where((b) => b.id.equals(t.id))).write(IncomeSourcesCompanion(remoteId: Value(id)));
      }

      final iiRows = await (select(incomeInstances)..where((t) => t.profileId.equals(profile) & t.remoteId.isNull())).get();
      for (final t in iiRows) {
        final id = await _ensureRemoteId(t.remoteId);
        await (update(incomeInstances)..where((b) => b.id.equals(t.id))).write(IncomeInstancesCompanion(remoteId: Value(id)));
      }
    });
  }

  Future<void> _createRemoteIdIndexes(Migrator m) async {
    // Use partial unique indexes to avoid conflicts with NULL values.
    await m.database.customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_categories_remote_id ON categories(profile_id, remote_id) WHERE remote_id IS NOT NULL;');
    await m.database.customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_bill_templates_remote_id ON bill_templates(profile_id, remote_id) WHERE remote_id IS NOT NULL;');
    await m.database.customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_bill_instances_remote_id ON bill_instances(profile_id, remote_id) WHERE remote_id IS NOT NULL;');
    await m.database.customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_income_sources_remote_id ON income_sources(profile_id, remote_id) WHERE remote_id IS NOT NULL;');
    await m.database.customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_income_instances_remote_id ON income_instances(profile_id, remote_id) WHERE remote_id IS NOT NULL;');
  }

  Future<String> ensureDeviceId(String? existing) async {
    if (existing != null && existing.isNotEmpty) return existing;
    final newId = const Uuid().v4();
    final settings = await ensureSyncSettingsRow();
    await saveSyncSettings(
      useRemote: settings.useRemote,
      mode: settings.mode,
      baseUrl: settings.baseUrl,
      apiKey: settings.apiKey,
      lastSyncServerMs: settings.lastSyncServerMs,
      deviceId: newId,
    );
    return newId;
  }

  // ------------ Sync settings operations ------------

  Future<SyncSetting> ensureSyncSettingsRow({String? profileId}) async {
    final pid = profileId ?? profile;
    final existing = await (select(syncSettings)..where((s) => s.profileId.equals(pid))..limit(1)).get();
    if (existing.isNotEmpty) return existing.first;
    final id = await into(syncSettings).insert(
      SyncSettingsCompanion(
        profileId: Value(pid),
        useRemote: const Value(false),
        mode: const Value('local_only'),
      ),
    );
    return (select(syncSettings)..where((s) => s.id.equals(id))).getSingle();
  }

  Stream<SyncSetting?> watchSyncSettings() {
    final q = (select(syncSettings)..where((s) => s.profileId.equals(profile))..limit(1));
    return q.watchSingleOrNull();
  }

  Future<SyncSetting> getSyncSettingsOnce() async {
    final existing = await (select(syncSettings)..where((s) => s.profileId.equals(profile))..limit(1)).get();
    if (existing.isNotEmpty) return existing.first;
    return ensureSyncSettingsRow();
  }

  Future<void> saveSyncSettings({
    required bool useRemote,
    required String mode,
    String? baseUrl,
    String? apiKey,
    int? lastSyncServerMs,
    String? deviceId,
    String? profileId,
  }) async {
    final pid = profileId ?? profile;
    final current = await ensureSyncSettingsRow(profileId: pid);
    await (update(syncSettings)..where((s) => s.id.equals(current.id))).write(
      SyncSettingsCompanion(
        profileId: Value(pid),
        useRemote: Value(useRemote),
        mode: Value(mode),
        baseUrl: Value(baseUrl),
        apiKey: Value(apiKey),
        updatedAt: Value(DateTime.now()),
        lastSyncServerMs: Value(lastSyncServerMs ?? 0),
        deviceId: Value(deviceId),
      ),
    );
  }

  // ------------ Outbox (for sync) ------------

  Future<int> enqueueOutbox({
    required String entityType,
    required String entityId,
    required String op,
    Map<String, dynamic>? payload,
  }) {
    return into(outboxEntries).insert(
      OutboxEntriesCompanion.insert(
        profileId: Value(profile),
        entityType: entityType,
        entityId: entityId,
        op: op,
        payloadJson: Value(payload == null ? null : jsonEncode(payload)),
      ),
    );
  }

  Future<List<OutboxEntry>> getOutboxBatch({int limit = 100}) {
    final q = (select(outboxEntries)
      ..where((o) => o.profileId.equals(profile))
      ..orderBy([(o) => OrderingTerm.asc(o.queuedAt)])
      ..limit(limit));
    return q.get();
  }

  Future<void> clearOutboxIds(List<int> ids) async {
    if (ids.isEmpty) return;
    await (delete(outboxEntries)..where((o) => o.id.isIn(ids))).go();
  }

  // ------------ Category operations ------------

  Future<List<Category>> getAllCategories() {
    return (select(categories)
          ..where((c) => c.profileId.equals(profile))
          ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
        .get();
  }

  Stream<List<Category>> watchAllCategories() {
    return (select(categories)
          ..where((c) => c.profileId.equals(profile))
          ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
        .watch();
  }

  Future<int> addCategory({required String name, String? color}) {
    final uuid = const Uuid().v4();
    return into(categories).insert(CategoriesCompanion.insert(
      profileId: Value(profile),
      name: name,
      color: Value(color),
      remoteId: Value(uuid),
    ));
  }

  // ------------ Bill Template operations ------------

  Future<List<BillTemplate>> getAllBillTemplates() {
    return (select(billTemplates)
          ..where((t) => t.profileId.equals(profile))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Stream<List<BillTemplate>> watchAllBillTemplates() {
    return (select(billTemplates)
          ..where((t) => t.profileId.equals(profile))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  Future<List<BillTemplate>> getActiveBillTemplates() {
    return (select(billTemplates)
      ..where((t) => t.profileId.equals(profile) & t.active.equals(true) & t.recurrenceRule.isNotNull())
      ..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Future<int> upsertBillTemplate({
    int? id,
    required String name,
    String? category,
    String? categoryRemoteId,
    required int defaultAmountCents,
    String? startDate,
    String? recurrenceRuleJson,
    bool active = true,
  }) async {
    final existing = id == null
        ? null
        : await (select(billTemplates)
              ..where((t) => t.profileId.equals(profile) & t.id.equals(id)))
            .getSingleOrNull();
    final remoteId = existing?.remoteId ?? const Uuid().v4();
    final companion = BillTemplatesCompanion(
      profileId: Value(profile),
      id: id == null ? const Value.absent() : Value(id),
      remoteId: Value(remoteId),
      name: Value(name),
      category: Value(category),
      categoryRemoteId: Value(categoryRemoteId),
      defaultAmountCents: Value(defaultAmountCents),
      startDate: Value(startDate),
      recurrenceRule: Value(recurrenceRuleJson),
      active: Value(active),
    );

    if (id == null) {
      return into(billTemplates).insert(companion);
    }
    await (update(billTemplates)..where((t) => t.profileId.equals(profile) & t.id.equals(id))).write(companion);
    return id;
  }

  Future<void> deleteBillTemplate(int id) async {
    final row = await (select(billTemplates)..where((t) => t.profileId.equals(profile) & t.id.equals(id))).getSingleOrNull();
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_templates', entityId: row!.remoteId!, op: 'delete');
    }
    await (delete(billTemplates)..where((t) => t.profileId.equals(profile) & t.id.equals(id))).go();
  }

  Future<void> toggleBillTemplateActive(int id, bool active) async {
    await (update(billTemplates)..where((t) => t.profileId.equals(profile) & t.id.equals(id))).write(
      BillTemplatesCompanion(active: Value(active)),
    );
  }

  // ------------ Bill Instance operations ------------

  Future<List<BillInstance>> getBillInstancesForDate(String dateStr) {
    return (select(billInstances)
      ..where((i) => i.profileId.equals(profile) & i.dueDate.equals(dateStr) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.id)])).get();
  }

  Stream<List<BillInstance>> watchBillInstancesForDate(String dateStr) {
    return (select(billInstances)
      ..where((i) => i.profileId.equals(profile) & i.dueDate.equals(dateStr) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.id)])).watch();
  }

  Future<List<BillInstance>> getBillInstancesForMonth(String startDate, String endDate) {
    return (select(billInstances)
      ..where((i) => i.profileId.equals(profile) & i.dueDate.isBetweenValues(startDate, endDate) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.dueDate)])).get();
  }

  Stream<List<BillInstance>> watchAllBillInstances() {
    return (select(billInstances)
          ..where((i) => i.profileId.equals(profile))
          ..orderBy([(i) => OrderingTerm.desc(i.dueDate)]))
        .watch();
  }

  Stream<List<BillInstance>> watchBillInstancesForMonth(String startDate, String endDate) {
    return (select(billInstances)
      ..where((i) => i.profileId.equals(profile) & i.dueDate.isBetweenValues(startDate, endDate))
      ..orderBy([(i) => OrderingTerm.asc(i.dueDate)])).watch();
  }

  Future<BillInstance?> getBillInstanceByTemplateAndDate(int templateId, String dateStr) {
    return (select(billInstances)
      ..where((i) => i.profileId.equals(profile) & i.templateId.equals(templateId) & i.dueDate.equals(dateStr)))
        .getSingleOrNull();
  }

  Future<int> addOneTimeBillInstance({
    required String title,
    required int amountCents,
    required String dueDate,
    String? notes,
    String? category,
  }) {
    final uuid = const Uuid().v4();
    return transaction(() async {
      final id = await into(billInstances).insert(
        BillInstancesCompanion(
          profileId: Value(profile),
          remoteId: Value(uuid),
          templateId: const Value(null),
          titleSnapshot: Value(title),
          amountCents: Value(amountCents),
          dueDate: Value(dueDate),
          notes: Value(notes),
          category: Value(category),
        ),
      );
      await enqueueOutbox(entityType: 'bill_instances', entityId: uuid, op: 'upsert');
      return id;
    });
  }

  Future<int> addRecurringBillInstance({
    required int templateId,
    required String title,
    required int amountCents,
    required String dueDate,
    String? category,
  }) {
    final uuid = const Uuid().v4();
    return transaction(() async {
      final id = await into(billInstances).insert(
        BillInstancesCompanion(
          profileId: Value(profile),
          remoteId: Value(uuid),
          templateId: Value(templateId),
          titleSnapshot: Value(title),
          amountCents: Value(amountCents),
          dueDate: Value(dueDate),
          category: Value(category),
        ),
      );
      await enqueueOutbox(entityType: 'bill_instances', entityId: uuid, op: 'upsert');
      return id;
    });
  }

  Future<void> markBillPaid({
    required int instanceId,
    required int paidAmountCents,
  }) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      BillInstancesCompanion(
        status: const Value('paid'),
        paidAmountCents: Value(paidAmountCents),
        paidAt: Value(DateTime.now()),
      ),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> markBillPartialPaid({
    required int instanceId,
    required int paidAmountCents,
  }) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      BillInstancesCompanion(
        status: const Value('partial'),
        paidAmountCents: Value(paidAmountCents),
        paidAt: Value(DateTime.now()),
      ),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> markBillUnpaid({required int instanceId}) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      const BillInstancesCompanion(
        status: Value('scheduled'),
        paidAmountCents: Value(null),
        paidAt: Value(null),
      ),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> skipBillInstance({required int instanceId}) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      const BillInstancesCompanion(status: Value('skipped')),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> unskipBillInstance({required int instanceId}) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      const BillInstancesCompanion(status: Value('scheduled')),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> updateBillInstanceAmount({
    required int instanceId,
    required int amountCents,
  }) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      BillInstancesCompanion(amountCents: Value(amountCents)),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> updateBillInstanceNotes({
    required int instanceId,
    String? notes,
  }) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      BillInstancesCompanion(notes: Value(notes)),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> deleteBillInstance(int id) async {
    final row = await (select(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(id))).getSingleOrNull();
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'bill_instances', entityId: row!.remoteId!, op: 'delete');
    }
    await (delete(billInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(id))).go();
  }

  // ------------ Income Source operations ------------

  Future<List<IncomeSource>> getAllIncomeSources() {
    return (select(incomeSources)
          ..where((s) => s.profileId.equals(profile))
          ..orderBy([(s) => OrderingTerm.asc(s.name)]))
        .get();
  }

  Stream<List<IncomeSource>> watchAllIncomeSources() {
    return (select(incomeSources)
          ..where((s) => s.profileId.equals(profile))
          ..orderBy([(s) => OrderingTerm.asc(s.name)]))
        .watch();
  }

  Future<List<IncomeSource>> getActiveIncomeSources() {
    return (select(incomeSources)
      ..where((s) => s.profileId.equals(profile) & s.active.equals(true))
      ..orderBy([(s) => OrderingTerm.asc(s.name)])).get();
  }

  Future<int> upsertIncomeSource({
    int? id,
    required String name,
    required int amountCents,
    required String frequency,
    String? startDate,
    String? anchorDate,
    bool active = true,
  }) async {
    final existing = id == null
        ? null
        : await (select(incomeSources)
              ..where((s) => s.profileId.equals(profile) & s.id.equals(id)))
            .getSingleOrNull();
    final remoteId = existing?.remoteId ?? const Uuid().v4();
    final companion = IncomeSourcesCompanion(
      profileId: Value(profile),
      id: id == null ? const Value.absent() : Value(id),
      remoteId: Value(remoteId),
      name: Value(name),
      amountCents: Value(amountCents),
      frequency: Value(frequency),
      startDate: Value(startDate),
      anchorDate: Value(anchorDate),
      active: Value(active),
    );

    if (id == null) {
      return into(incomeSources).insert(companion);
    }
    await (update(incomeSources)..where((s) => s.profileId.equals(profile) & s.id.equals(id))).write(companion);
    return id;
  }

  Future<void> deleteIncomeSource(int id) async {
    final row = await (select(incomeSources)..where((s) => s.profileId.equals(profile) & s.id.equals(id))).getSingleOrNull();
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'income_sources', entityId: row!.remoteId!, op: 'delete');
    }
    await (delete(incomeSources)..where((s) => s.profileId.equals(profile) & s.id.equals(id))).go();
  }

  // ------------ Income Instance operations ------------

  Future<List<IncomeInstance>> getIncomeInstancesForMonth(String startDate, String endDate) {
    return (select(incomeInstances)
      ..where((i) => i.profileId.equals(profile) & i.date.isBetweenValues(startDate, endDate) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.date)])).get();
  }

  Stream<List<IncomeInstance>> watchIncomeInstancesForMonth(String startDate, String endDate) {
    return (select(incomeInstances)
      ..where((i) => i.profileId.equals(profile) & i.date.isBetweenValues(startDate, endDate))
      ..orderBy([(i) => OrderingTerm.asc(i.date)])).watch();
  }

  Stream<List<IncomeInstance>> watchAllIncomeInstances() {
    return (select(incomeInstances)
          ..where((i) => i.profileId.equals(profile))
          ..orderBy([(i) => OrderingTerm.desc(i.date)]))
        .watch();
  }

  Future<IncomeInstance?> getIncomeInstanceBySourceAndDate(int sourceId, String dateStr) {
    return (select(incomeInstances)
      ..where((i) => i.profileId.equals(profile) & i.sourceId.equals(sourceId) & i.date.equals(dateStr)))
        .getSingleOrNull();
  }

  Future<int> addOneTimeIncomeInstance({
    required String title,
    required int amountCents,
    required String date,
    String? notes,
  }) {
    final uuid = const Uuid().v4();
    return transaction(() async {
      final id = await into(incomeInstances).insert(
        IncomeInstancesCompanion(
          profileId: Value(profile),
          remoteId: Value(uuid),
          sourceId: const Value(null),
          titleSnapshot: Value(title),
          amountCents: Value(amountCents),
          date: Value(date),
          notes: Value(notes),
        ),
      );
      await enqueueOutbox(entityType: 'income_instances', entityId: uuid, op: 'upsert');
      return id;
    });
  }

  Future<int> addRecurringIncomeInstance({
    required int sourceId,
    required String title,
    required int amountCents,
    required String date,
  }) {
    final uuid = const Uuid().v4();
    return transaction(() async {
      final id = await into(incomeInstances).insert(
        IncomeInstancesCompanion(
          profileId: Value(profile),
          remoteId: Value(uuid),
          sourceId: Value(sourceId),
          titleSnapshot: Value(title),
          amountCents: Value(amountCents),
          date: Value(date),
        ),
      );
      await enqueueOutbox(entityType: 'income_instances', entityId: uuid, op: 'upsert');
      return id;
    });
  }

  Future<void> markIncomeReceived({required int instanceId}) async {
    final row = await (select(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      IncomeInstancesCompanion(
        status: const Value('received'),
        receivedAt: Value(DateTime.now()),
      ),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'income_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> markIncomeExpected({required int instanceId}) async {
    final row = await (select(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      const IncomeInstancesCompanion(
        status: Value('expected'),
        receivedAt: Value(null),
      ),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'income_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> skipIncomeInstance({required int instanceId}) async {
    final row = await (select(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      const IncomeInstancesCompanion(status: Value('skipped')),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'income_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> updateIncomeInstanceAmount({
    required int instanceId,
    required int amountCents,
  }) async {
    final row = await (select(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).getSingleOrNull();
    await (update(incomeInstances)..where((i) => i.profileId.equals(profile) & i.id.equals(instanceId))).write(
      IncomeInstancesCompanion(amountCents: Value(amountCents)),
    );
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'income_instances', entityId: row!.remoteId!, op: 'upsert');
    }
  }

  Future<void> deleteIncomeInstance(int id) async {
    final row = await (select(incomeInstances)..where((s) => s.profileId.equals(profile) & s.id.equals(id))).getSingleOrNull();
    if (row?.remoteId != null) {
      await enqueueOutbox(entityType: 'income_instances', entityId: row!.remoteId!, op: 'delete');
    }
    await (delete(incomeInstances)..where((s) => s.profileId.equals(profile) & s.id.equals(id))).go();
  }

  // ------------ Dashboard calculations ------------

  Future<Map<String, int>> getMonthSummary(String startDate, String endDate) async {
    final bills = await getBillInstancesForMonth(startDate, endDate);
    final income = await getIncomeInstancesForMonth(startDate, endDate);

    int billsScheduled = 0;
    int billsPaid = 0;
    int incomeProjected = 0;
    int incomeReceived = 0;

    for (final b in bills) {
      if (b.status != 'skipped') {
        billsScheduled += b.amountCents;
        if (b.status == 'paid' || b.status == 'partial') {
          billsPaid += b.paidAmountCents ?? b.amountCents;
        }
      }
    }

    for (final i in income) {
      if (i.status != 'skipped') {
        incomeProjected += i.amountCents;
        if (i.status == 'received') {
          incomeReceived += i.amountCents;
        }
      }
    }

    return {
      'billsScheduled': billsScheduled,
      'billsPaid': billsPaid,
      'incomeProjected': incomeProjected,
      'incomeReceived': incomeReceived,
    };
  }

  Future<Map<String, int>> getNext7DaysSummary(String startDate, String endDate) async {
    final bills = await (select(billInstances)
      ..where((i) => i.profileId.equals(profile) & i.dueDate.isBetweenValues(startDate, endDate) & i.status.equals('scheduled'))
      ..orderBy([(i) => OrderingTerm.asc(i.dueDate)])).get();

    int total = 0;
    for (final b in bills) {
      total += b.amountCents;
    }

    return {
      'count': bills.length,
      'total': total,
    };
  }

  Future<Map<String, int>> getCategoryBreakdown(String startDate, String endDate) async {
    final bills = await getBillInstancesForMonth(startDate, endDate);
    final breakdown = <String, int>{};

    for (final b in bills) {
      if (b.status != 'skipped') {
        final cat = b.category ?? 'Other';
        breakdown[cat] = (breakdown[cat] ?? 0) + b.amountCents;
      }
    }

    return breakdown;
  }
}
