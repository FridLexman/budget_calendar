// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BillTemplatesTable extends BillTemplates
    with TableInfo<$BillTemplatesTable, BillTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryRemoteIdMeta =
      const VerificationMeta('categoryRemoteId');
  @override
  late final GeneratedColumn<String> categoryRemoteId = GeneratedColumn<String>(
      'category_remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _defaultAmountCentsMeta =
      const VerificationMeta('defaultAmountCents');
  @override
  late final GeneratedColumn<int> defaultAmountCents = GeneratedColumn<int>(
      'default_amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _recurrenceRuleMeta =
      const VerificationMeta('recurrenceRule');
  @override
  late final GeneratedColumn<String> recurrenceRule = GeneratedColumn<String>(
      'recurrence_rule', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtServerMeta =
      const VerificationMeta('updatedAtServer');
  @override
  late final GeneratedColumn<int> updatedAtServer = GeneratedColumn<int>(
      'updated_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtServerMeta =
      const VerificationMeta('deletedAtServer');
  @override
  late final GeneratedColumn<int> deletedAtServer = GeneratedColumn<int>(
      'deleted_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientUpdatedAtMeta =
      const VerificationMeta('clientUpdatedAt');
  @override
  late final GeneratedColumn<int> clientUpdatedAt = GeneratedColumn<int>(
      'client_updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        remoteId,
        householdId,
        name,
        category,
        categoryRemoteId,
        defaultAmountCents,
        startDate,
        active,
        recurrenceRule,
        createdAt,
        updatedAtServer,
        deletedAtServer,
        deviceId,
        clientUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_templates';
  @override
  VerificationContext validateIntegrity(Insertable<BillTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('category_remote_id')) {
      context.handle(
          _categoryRemoteIdMeta,
          categoryRemoteId.isAcceptableOrUnknown(
              data['category_remote_id']!, _categoryRemoteIdMeta));
    }
    if (data.containsKey('default_amount_cents')) {
      context.handle(
          _defaultAmountCentsMeta,
          defaultAmountCents.isAcceptableOrUnknown(
              data['default_amount_cents']!, _defaultAmountCentsMeta));
    } else if (isInserting) {
      context.missing(_defaultAmountCentsMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('recurrence_rule')) {
      context.handle(
          _recurrenceRuleMeta,
          recurrenceRule.isAcceptableOrUnknown(
              data['recurrence_rule']!, _recurrenceRuleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at_server')) {
      context.handle(
          _updatedAtServerMeta,
          updatedAtServer.isAcceptableOrUnknown(
              data['updated_at_server']!, _updatedAtServerMeta));
    }
    if (data.containsKey('deleted_at_server')) {
      context.handle(
          _deletedAtServerMeta,
          deletedAtServer.isAcceptableOrUnknown(
              data['deleted_at_server']!, _deletedAtServerMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
          _clientUpdatedAtMeta,
          clientUpdatedAt.isAcceptableOrUnknown(
              data['client_updated_at']!, _clientUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      categoryRemoteId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}category_remote_id']),
      defaultAmountCents: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}default_amount_cents'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      recurrenceRule: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurrence_rule']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_server']),
      deletedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at_server']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      clientUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_updated_at']),
    );
  }

  @override
  $BillTemplatesTable createAlias(String alias) {
    return $BillTemplatesTable(attachedDatabase, alias);
  }
}

class BillTemplate extends DataClass implements Insertable<BillTemplate> {
  final int id;
  final String profileId;
  final String? remoteId;
  final String? householdId;
  final String name;
  final String? category;
  final String? categoryRemoteId;
  final int defaultAmountCents;
  final String? startDate;
  final bool active;

  /// JSON string, e.g. {"type":"monthly","day":1}
  final String? recurrenceRule;
  final DateTime createdAt;
  final int? updatedAtServer;
  final int? deletedAtServer;
  final String? deviceId;
  final int? clientUpdatedAt;
  const BillTemplate(
      {required this.id,
      required this.profileId,
      this.remoteId,
      this.householdId,
      required this.name,
      this.category,
      this.categoryRemoteId,
      required this.defaultAmountCents,
      this.startDate,
      required this.active,
      this.recurrenceRule,
      required this.createdAt,
      this.updatedAtServer,
      this.deletedAtServer,
      this.deviceId,
      this.clientUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || householdId != null) {
      map['household_id'] = Variable<String>(householdId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || categoryRemoteId != null) {
      map['category_remote_id'] = Variable<String>(categoryRemoteId);
    }
    map['default_amount_cents'] = Variable<int>(defaultAmountCents);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAtServer != null) {
      map['updated_at_server'] = Variable<int>(updatedAtServer);
    }
    if (!nullToAbsent || deletedAtServer != null) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || clientUpdatedAt != null) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt);
    }
    return map;
  }

  BillTemplatesCompanion toCompanion(bool nullToAbsent) {
    return BillTemplatesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      householdId: householdId == null && nullToAbsent
          ? const Value.absent()
          : Value(householdId),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      categoryRemoteId: categoryRemoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryRemoteId),
      defaultAmountCents: Value(defaultAmountCents),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      active: Value(active),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      createdAt: Value(createdAt),
      updatedAtServer: updatedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtServer),
      deletedAtServer: deletedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtServer),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      clientUpdatedAt: clientUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientUpdatedAt),
    );
  }

  factory BillTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillTemplate(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      householdId: serializer.fromJson<String?>(json['householdId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      categoryRemoteId: serializer.fromJson<String?>(json['categoryRemoteId']),
      defaultAmountCents: serializer.fromJson<int>(json['defaultAmountCents']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      active: serializer.fromJson<bool>(json['active']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrenceRule']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAtServer: serializer.fromJson<int?>(json['updatedAtServer']),
      deletedAtServer: serializer.fromJson<int?>(json['deletedAtServer']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      clientUpdatedAt: serializer.fromJson<int?>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'householdId': serializer.toJson<String?>(householdId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'categoryRemoteId': serializer.toJson<String?>(categoryRemoteId),
      'defaultAmountCents': serializer.toJson<int>(defaultAmountCents),
      'startDate': serializer.toJson<String?>(startDate),
      'active': serializer.toJson<bool>(active),
      'recurrenceRule': serializer.toJson<String?>(recurrenceRule),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAtServer': serializer.toJson<int?>(updatedAtServer),
      'deletedAtServer': serializer.toJson<int?>(deletedAtServer),
      'deviceId': serializer.toJson<String?>(deviceId),
      'clientUpdatedAt': serializer.toJson<int?>(clientUpdatedAt),
    };
  }

  BillTemplate copyWith(
          {int? id,
          String? profileId,
          Value<String?> remoteId = const Value.absent(),
          Value<String?> householdId = const Value.absent(),
          String? name,
          Value<String?> category = const Value.absent(),
          Value<String?> categoryRemoteId = const Value.absent(),
          int? defaultAmountCents,
          Value<String?> startDate = const Value.absent(),
          bool? active,
          Value<String?> recurrenceRule = const Value.absent(),
          DateTime? createdAt,
          Value<int?> updatedAtServer = const Value.absent(),
          Value<int?> deletedAtServer = const Value.absent(),
          Value<String?> deviceId = const Value.absent(),
          Value<int?> clientUpdatedAt = const Value.absent()}) =>
      BillTemplate(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        householdId: householdId.present ? householdId.value : this.householdId,
        name: name ?? this.name,
        category: category.present ? category.value : this.category,
        categoryRemoteId: categoryRemoteId.present
            ? categoryRemoteId.value
            : this.categoryRemoteId,
        defaultAmountCents: defaultAmountCents ?? this.defaultAmountCents,
        startDate: startDate.present ? startDate.value : this.startDate,
        active: active ?? this.active,
        recurrenceRule:
            recurrenceRule.present ? recurrenceRule.value : this.recurrenceRule,
        createdAt: createdAt ?? this.createdAt,
        updatedAtServer: updatedAtServer.present
            ? updatedAtServer.value
            : this.updatedAtServer,
        deletedAtServer: deletedAtServer.present
            ? deletedAtServer.value
            : this.deletedAtServer,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        clientUpdatedAt: clientUpdatedAt.present
            ? clientUpdatedAt.value
            : this.clientUpdatedAt,
      );
  BillTemplate copyWithCompanion(BillTemplatesCompanion data) {
    return BillTemplate(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      categoryRemoteId: data.categoryRemoteId.present
          ? data.categoryRemoteId.value
          : this.categoryRemoteId,
      defaultAmountCents: data.defaultAmountCents.present
          ? data.defaultAmountCents.value
          : this.defaultAmountCents,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      active: data.active.present ? data.active.value : this.active,
      recurrenceRule: data.recurrenceRule.present
          ? data.recurrenceRule.value
          : this.recurrenceRule,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAtServer: data.updatedAtServer.present
          ? data.updatedAtServer.value
          : this.updatedAtServer,
      deletedAtServer: data.deletedAtServer.present
          ? data.deletedAtServer.value
          : this.deletedAtServer,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillTemplate(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('categoryRemoteId: $categoryRemoteId, ')
          ..write('defaultAmountCents: $defaultAmountCents, ')
          ..write('startDate: $startDate, ')
          ..write('active: $active, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      profileId,
      remoteId,
      householdId,
      name,
      category,
      categoryRemoteId,
      defaultAmountCents,
      startDate,
      active,
      recurrenceRule,
      createdAt,
      updatedAtServer,
      deletedAtServer,
      deviceId,
      clientUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillTemplate &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.remoteId == this.remoteId &&
          other.householdId == this.householdId &&
          other.name == this.name &&
          other.category == this.category &&
          other.categoryRemoteId == this.categoryRemoteId &&
          other.defaultAmountCents == this.defaultAmountCents &&
          other.startDate == this.startDate &&
          other.active == this.active &&
          other.recurrenceRule == this.recurrenceRule &&
          other.createdAt == this.createdAt &&
          other.updatedAtServer == this.updatedAtServer &&
          other.deletedAtServer == this.deletedAtServer &&
          other.deviceId == this.deviceId &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class BillTemplatesCompanion extends UpdateCompanion<BillTemplate> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String?> remoteId;
  final Value<String?> householdId;
  final Value<String> name;
  final Value<String?> category;
  final Value<String?> categoryRemoteId;
  final Value<int> defaultAmountCents;
  final Value<String?> startDate;
  final Value<bool> active;
  final Value<String?> recurrenceRule;
  final Value<DateTime> createdAt;
  final Value<int?> updatedAtServer;
  final Value<int?> deletedAtServer;
  final Value<String?> deviceId;
  final Value<int?> clientUpdatedAt;
  const BillTemplatesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryRemoteId = const Value.absent(),
    this.defaultAmountCents = const Value.absent(),
    this.startDate = const Value.absent(),
    this.active = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  BillTemplatesCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.categoryRemoteId = const Value.absent(),
    required int defaultAmountCents,
    this.startDate = const Value.absent(),
    this.active = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  })  : name = Value(name),
        defaultAmountCents = Value(defaultAmountCents);
  static Insertable<BillTemplate> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? remoteId,
    Expression<String>? householdId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? categoryRemoteId,
    Expression<int>? defaultAmountCents,
    Expression<String>? startDate,
    Expression<bool>? active,
    Expression<String>? recurrenceRule,
    Expression<DateTime>? createdAt,
    Expression<int>? updatedAtServer,
    Expression<int>? deletedAtServer,
    Expression<String>? deviceId,
    Expression<int>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (remoteId != null) 'remote_id': remoteId,
      if (householdId != null) 'household_id': householdId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (categoryRemoteId != null) 'category_remote_id': categoryRemoteId,
      if (defaultAmountCents != null)
        'default_amount_cents': defaultAmountCents,
      if (startDate != null) 'start_date': startDate,
      if (active != null) 'active': active,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAtServer != null) 'updated_at_server': updatedAtServer,
      if (deletedAtServer != null) 'deleted_at_server': deletedAtServer,
      if (deviceId != null) 'device_id': deviceId,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  BillTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String?>? remoteId,
      Value<String?>? householdId,
      Value<String>? name,
      Value<String?>? category,
      Value<String?>? categoryRemoteId,
      Value<int>? defaultAmountCents,
      Value<String?>? startDate,
      Value<bool>? active,
      Value<String?>? recurrenceRule,
      Value<DateTime>? createdAt,
      Value<int?>? updatedAtServer,
      Value<int?>? deletedAtServer,
      Value<String?>? deviceId,
      Value<int?>? clientUpdatedAt}) {
    return BillTemplatesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      remoteId: remoteId ?? this.remoteId,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      category: category ?? this.category,
      categoryRemoteId: categoryRemoteId ?? this.categoryRemoteId,
      defaultAmountCents: defaultAmountCents ?? this.defaultAmountCents,
      startDate: startDate ?? this.startDate,
      active: active ?? this.active,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      createdAt: createdAt ?? this.createdAt,
      updatedAtServer: updatedAtServer ?? this.updatedAtServer,
      deletedAtServer: deletedAtServer ?? this.deletedAtServer,
      deviceId: deviceId ?? this.deviceId,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryRemoteId.present) {
      map['category_remote_id'] = Variable<String>(categoryRemoteId.value);
    }
    if (defaultAmountCents.present) {
      map['default_amount_cents'] = Variable<int>(defaultAmountCents.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (recurrenceRule.present) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAtServer.present) {
      map['updated_at_server'] = Variable<int>(updatedAtServer.value);
    }
    if (deletedAtServer.present) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('categoryRemoteId: $categoryRemoteId, ')
          ..write('defaultAmountCents: $defaultAmountCents, ')
          ..write('startDate: $startDate, ')
          ..write('active: $active, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $BillInstancesTable extends BillInstances
    with TableInfo<$BillInstancesTable, BillInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _templateRemoteIdMeta =
      const VerificationMeta('templateRemoteId');
  @override
  late final GeneratedColumn<String> templateRemoteId = GeneratedColumn<String>(
      'template_remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleSnapshotMeta =
      const VerificationMeta('titleSnapshot');
  @override
  late final GeneratedColumn<String> titleSnapshot = GeneratedColumn<String>(
      'title_snapshot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountCentsMeta =
      const VerificationMeta('amountCents');
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
      'amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
      'due_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('scheduled'));
  static const VerificationMeta _paidAmountCentsMeta =
      const VerificationMeta('paidAmountCents');
  @override
  late final GeneratedColumn<int> paidAmountCents = GeneratedColumn<int>(
      'paid_amount_cents', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
      'paid_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryRemoteIdMeta =
      const VerificationMeta('categoryRemoteId');
  @override
  late final GeneratedColumn<String> categoryRemoteId = GeneratedColumn<String>(
      'category_remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtServerMeta =
      const VerificationMeta('updatedAtServer');
  @override
  late final GeneratedColumn<int> updatedAtServer = GeneratedColumn<int>(
      'updated_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtServerMeta =
      const VerificationMeta('deletedAtServer');
  @override
  late final GeneratedColumn<int> deletedAtServer = GeneratedColumn<int>(
      'deleted_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientUpdatedAtMeta =
      const VerificationMeta('clientUpdatedAt');
  @override
  late final GeneratedColumn<int> clientUpdatedAt = GeneratedColumn<int>(
      'client_updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        remoteId,
        householdId,
        templateId,
        templateRemoteId,
        titleSnapshot,
        amountCents,
        dueDate,
        status,
        paidAmountCents,
        paidAt,
        notes,
        category,
        categoryRemoteId,
        createdAt,
        updatedAtServer,
        deletedAtServer,
        deviceId,
        clientUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_instances';
  @override
  VerificationContext validateIntegrity(Insertable<BillInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    }
    if (data.containsKey('template_remote_id')) {
      context.handle(
          _templateRemoteIdMeta,
          templateRemoteId.isAcceptableOrUnknown(
              data['template_remote_id']!, _templateRemoteIdMeta));
    }
    if (data.containsKey('title_snapshot')) {
      context.handle(
          _titleSnapshotMeta,
          titleSnapshot.isAcceptableOrUnknown(
              data['title_snapshot']!, _titleSnapshotMeta));
    } else if (isInserting) {
      context.missing(_titleSnapshotMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
          _amountCentsMeta,
          amountCents.isAcceptableOrUnknown(
              data['amount_cents']!, _amountCentsMeta));
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('paid_amount_cents')) {
      context.handle(
          _paidAmountCentsMeta,
          paidAmountCents.isAcceptableOrUnknown(
              data['paid_amount_cents']!, _paidAmountCentsMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta,
          paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('category_remote_id')) {
      context.handle(
          _categoryRemoteIdMeta,
          categoryRemoteId.isAcceptableOrUnknown(
              data['category_remote_id']!, _categoryRemoteIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at_server')) {
      context.handle(
          _updatedAtServerMeta,
          updatedAtServer.isAcceptableOrUnknown(
              data['updated_at_server']!, _updatedAtServerMeta));
    }
    if (data.containsKey('deleted_at_server')) {
      context.handle(
          _deletedAtServerMeta,
          deletedAtServer.isAcceptableOrUnknown(
              data['deleted_at_server']!, _deletedAtServerMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
          _clientUpdatedAtMeta,
          clientUpdatedAt.isAcceptableOrUnknown(
              data['client_updated_at']!, _clientUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillInstance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id']),
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id']),
      templateRemoteId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}template_remote_id']),
      titleSnapshot: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_snapshot'])!,
      amountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}due_date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      paidAmountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paid_amount_cents']),
      paidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      categoryRemoteId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}category_remote_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_server']),
      deletedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at_server']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      clientUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_updated_at']),
    );
  }

  @override
  $BillInstancesTable createAlias(String alias) {
    return $BillInstancesTable(attachedDatabase, alias);
  }
}

class BillInstance extends DataClass implements Insertable<BillInstance> {
  final int id;
  final String profileId;
  final String? remoteId;
  final String? householdId;
  final int? templateId;
  final String? templateRemoteId;
  final String titleSnapshot;
  final int amountCents;
  final String dueDate;
  final String status;
  final int? paidAmountCents;
  final DateTime? paidAt;
  final String? notes;
  final String? category;
  final String? categoryRemoteId;
  final DateTime createdAt;
  final int? updatedAtServer;
  final int? deletedAtServer;
  final String? deviceId;
  final int? clientUpdatedAt;
  const BillInstance(
      {required this.id,
      required this.profileId,
      this.remoteId,
      this.householdId,
      this.templateId,
      this.templateRemoteId,
      required this.titleSnapshot,
      required this.amountCents,
      required this.dueDate,
      required this.status,
      this.paidAmountCents,
      this.paidAt,
      this.notes,
      this.category,
      this.categoryRemoteId,
      required this.createdAt,
      this.updatedAtServer,
      this.deletedAtServer,
      this.deviceId,
      this.clientUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || householdId != null) {
      map['household_id'] = Variable<String>(householdId);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<int>(templateId);
    }
    if (!nullToAbsent || templateRemoteId != null) {
      map['template_remote_id'] = Variable<String>(templateRemoteId);
    }
    map['title_snapshot'] = Variable<String>(titleSnapshot);
    map['amount_cents'] = Variable<int>(amountCents);
    map['due_date'] = Variable<String>(dueDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || paidAmountCents != null) {
      map['paid_amount_cents'] = Variable<int>(paidAmountCents);
    }
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || categoryRemoteId != null) {
      map['category_remote_id'] = Variable<String>(categoryRemoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAtServer != null) {
      map['updated_at_server'] = Variable<int>(updatedAtServer);
    }
    if (!nullToAbsent || deletedAtServer != null) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || clientUpdatedAt != null) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt);
    }
    return map;
  }

  BillInstancesCompanion toCompanion(bool nullToAbsent) {
    return BillInstancesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      householdId: householdId == null && nullToAbsent
          ? const Value.absent()
          : Value(householdId),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      templateRemoteId: templateRemoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateRemoteId),
      titleSnapshot: Value(titleSnapshot),
      amountCents: Value(amountCents),
      dueDate: Value(dueDate),
      status: Value(status),
      paidAmountCents: paidAmountCents == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAmountCents),
      paidAt:
          paidAt == null && nullToAbsent ? const Value.absent() : Value(paidAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      categoryRemoteId: categoryRemoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryRemoteId),
      createdAt: Value(createdAt),
      updatedAtServer: updatedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtServer),
      deletedAtServer: deletedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtServer),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      clientUpdatedAt: clientUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientUpdatedAt),
    );
  }

  factory BillInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillInstance(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      householdId: serializer.fromJson<String?>(json['householdId']),
      templateId: serializer.fromJson<int?>(json['templateId']),
      templateRemoteId: serializer.fromJson<String?>(json['templateRemoteId']),
      titleSnapshot: serializer.fromJson<String>(json['titleSnapshot']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      status: serializer.fromJson<String>(json['status']),
      paidAmountCents: serializer.fromJson<int?>(json['paidAmountCents']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      category: serializer.fromJson<String?>(json['category']),
      categoryRemoteId: serializer.fromJson<String?>(json['categoryRemoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAtServer: serializer.fromJson<int?>(json['updatedAtServer']),
      deletedAtServer: serializer.fromJson<int?>(json['deletedAtServer']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      clientUpdatedAt: serializer.fromJson<int?>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'householdId': serializer.toJson<String?>(householdId),
      'templateId': serializer.toJson<int?>(templateId),
      'templateRemoteId': serializer.toJson<String?>(templateRemoteId),
      'titleSnapshot': serializer.toJson<String>(titleSnapshot),
      'amountCents': serializer.toJson<int>(amountCents),
      'dueDate': serializer.toJson<String>(dueDate),
      'status': serializer.toJson<String>(status),
      'paidAmountCents': serializer.toJson<int?>(paidAmountCents),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'notes': serializer.toJson<String?>(notes),
      'category': serializer.toJson<String?>(category),
      'categoryRemoteId': serializer.toJson<String?>(categoryRemoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAtServer': serializer.toJson<int?>(updatedAtServer),
      'deletedAtServer': serializer.toJson<int?>(deletedAtServer),
      'deviceId': serializer.toJson<String?>(deviceId),
      'clientUpdatedAt': serializer.toJson<int?>(clientUpdatedAt),
    };
  }

  BillInstance copyWith(
          {int? id,
          String? profileId,
          Value<String?> remoteId = const Value.absent(),
          Value<String?> householdId = const Value.absent(),
          Value<int?> templateId = const Value.absent(),
          Value<String?> templateRemoteId = const Value.absent(),
          String? titleSnapshot,
          int? amountCents,
          String? dueDate,
          String? status,
          Value<int?> paidAmountCents = const Value.absent(),
          Value<DateTime?> paidAt = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> categoryRemoteId = const Value.absent(),
          DateTime? createdAt,
          Value<int?> updatedAtServer = const Value.absent(),
          Value<int?> deletedAtServer = const Value.absent(),
          Value<String?> deviceId = const Value.absent(),
          Value<int?> clientUpdatedAt = const Value.absent()}) =>
      BillInstance(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        householdId: householdId.present ? householdId.value : this.householdId,
        templateId: templateId.present ? templateId.value : this.templateId,
        templateRemoteId: templateRemoteId.present
            ? templateRemoteId.value
            : this.templateRemoteId,
        titleSnapshot: titleSnapshot ?? this.titleSnapshot,
        amountCents: amountCents ?? this.amountCents,
        dueDate: dueDate ?? this.dueDate,
        status: status ?? this.status,
        paidAmountCents: paidAmountCents.present
            ? paidAmountCents.value
            : this.paidAmountCents,
        paidAt: paidAt.present ? paidAt.value : this.paidAt,
        notes: notes.present ? notes.value : this.notes,
        category: category.present ? category.value : this.category,
        categoryRemoteId: categoryRemoteId.present
            ? categoryRemoteId.value
            : this.categoryRemoteId,
        createdAt: createdAt ?? this.createdAt,
        updatedAtServer: updatedAtServer.present
            ? updatedAtServer.value
            : this.updatedAtServer,
        deletedAtServer: deletedAtServer.present
            ? deletedAtServer.value
            : this.deletedAtServer,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        clientUpdatedAt: clientUpdatedAt.present
            ? clientUpdatedAt.value
            : this.clientUpdatedAt,
      );
  BillInstance copyWithCompanion(BillInstancesCompanion data) {
    return BillInstance(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      templateRemoteId: data.templateRemoteId.present
          ? data.templateRemoteId.value
          : this.templateRemoteId,
      titleSnapshot: data.titleSnapshot.present
          ? data.titleSnapshot.value
          : this.titleSnapshot,
      amountCents:
          data.amountCents.present ? data.amountCents.value : this.amountCents,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
      paidAmountCents: data.paidAmountCents.present
          ? data.paidAmountCents.value
          : this.paidAmountCents,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      category: data.category.present ? data.category.value : this.category,
      categoryRemoteId: data.categoryRemoteId.present
          ? data.categoryRemoteId.value
          : this.categoryRemoteId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAtServer: data.updatedAtServer.present
          ? data.updatedAtServer.value
          : this.updatedAtServer,
      deletedAtServer: data.deletedAtServer.present
          ? data.deletedAtServer.value
          : this.deletedAtServer,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillInstance(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('templateId: $templateId, ')
          ..write('templateRemoteId: $templateRemoteId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidAmountCents: $paidAmountCents, ')
          ..write('paidAt: $paidAt, ')
          ..write('notes: $notes, ')
          ..write('category: $category, ')
          ..write('categoryRemoteId: $categoryRemoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      profileId,
      remoteId,
      householdId,
      templateId,
      templateRemoteId,
      titleSnapshot,
      amountCents,
      dueDate,
      status,
      paidAmountCents,
      paidAt,
      notes,
      category,
      categoryRemoteId,
      createdAt,
      updatedAtServer,
      deletedAtServer,
      deviceId,
      clientUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillInstance &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.remoteId == this.remoteId &&
          other.householdId == this.householdId &&
          other.templateId == this.templateId &&
          other.templateRemoteId == this.templateRemoteId &&
          other.titleSnapshot == this.titleSnapshot &&
          other.amountCents == this.amountCents &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.paidAmountCents == this.paidAmountCents &&
          other.paidAt == this.paidAt &&
          other.notes == this.notes &&
          other.category == this.category &&
          other.categoryRemoteId == this.categoryRemoteId &&
          other.createdAt == this.createdAt &&
          other.updatedAtServer == this.updatedAtServer &&
          other.deletedAtServer == this.deletedAtServer &&
          other.deviceId == this.deviceId &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class BillInstancesCompanion extends UpdateCompanion<BillInstance> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String?> remoteId;
  final Value<String?> householdId;
  final Value<int?> templateId;
  final Value<String?> templateRemoteId;
  final Value<String> titleSnapshot;
  final Value<int> amountCents;
  final Value<String> dueDate;
  final Value<String> status;
  final Value<int?> paidAmountCents;
  final Value<DateTime?> paidAt;
  final Value<String?> notes;
  final Value<String?> category;
  final Value<String?> categoryRemoteId;
  final Value<DateTime> createdAt;
  final Value<int?> updatedAtServer;
  final Value<int?> deletedAtServer;
  final Value<String?> deviceId;
  final Value<int?> clientUpdatedAt;
  const BillInstancesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.templateRemoteId = const Value.absent(),
    this.titleSnapshot = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.paidAmountCents = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryRemoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  BillInstancesCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.templateRemoteId = const Value.absent(),
    required String titleSnapshot,
    required int amountCents,
    required String dueDate,
    this.status = const Value.absent(),
    this.paidAmountCents = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryRemoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  })  : titleSnapshot = Value(titleSnapshot),
        amountCents = Value(amountCents),
        dueDate = Value(dueDate);
  static Insertable<BillInstance> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? remoteId,
    Expression<String>? householdId,
    Expression<int>? templateId,
    Expression<String>? templateRemoteId,
    Expression<String>? titleSnapshot,
    Expression<int>? amountCents,
    Expression<String>? dueDate,
    Expression<String>? status,
    Expression<int>? paidAmountCents,
    Expression<DateTime>? paidAt,
    Expression<String>? notes,
    Expression<String>? category,
    Expression<String>? categoryRemoteId,
    Expression<DateTime>? createdAt,
    Expression<int>? updatedAtServer,
    Expression<int>? deletedAtServer,
    Expression<String>? deviceId,
    Expression<int>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (remoteId != null) 'remote_id': remoteId,
      if (householdId != null) 'household_id': householdId,
      if (templateId != null) 'template_id': templateId,
      if (templateRemoteId != null) 'template_remote_id': templateRemoteId,
      if (titleSnapshot != null) 'title_snapshot': titleSnapshot,
      if (amountCents != null) 'amount_cents': amountCents,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (paidAmountCents != null) 'paid_amount_cents': paidAmountCents,
      if (paidAt != null) 'paid_at': paidAt,
      if (notes != null) 'notes': notes,
      if (category != null) 'category': category,
      if (categoryRemoteId != null) 'category_remote_id': categoryRemoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAtServer != null) 'updated_at_server': updatedAtServer,
      if (deletedAtServer != null) 'deleted_at_server': deletedAtServer,
      if (deviceId != null) 'device_id': deviceId,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  BillInstancesCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String?>? remoteId,
      Value<String?>? householdId,
      Value<int?>? templateId,
      Value<String?>? templateRemoteId,
      Value<String>? titleSnapshot,
      Value<int>? amountCents,
      Value<String>? dueDate,
      Value<String>? status,
      Value<int?>? paidAmountCents,
      Value<DateTime?>? paidAt,
      Value<String?>? notes,
      Value<String?>? category,
      Value<String?>? categoryRemoteId,
      Value<DateTime>? createdAt,
      Value<int?>? updatedAtServer,
      Value<int?>? deletedAtServer,
      Value<String?>? deviceId,
      Value<int?>? clientUpdatedAt}) {
    return BillInstancesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      remoteId: remoteId ?? this.remoteId,
      householdId: householdId ?? this.householdId,
      templateId: templateId ?? this.templateId,
      templateRemoteId: templateRemoteId ?? this.templateRemoteId,
      titleSnapshot: titleSnapshot ?? this.titleSnapshot,
      amountCents: amountCents ?? this.amountCents,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidAmountCents: paidAmountCents ?? this.paidAmountCents,
      paidAt: paidAt ?? this.paidAt,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      categoryRemoteId: categoryRemoteId ?? this.categoryRemoteId,
      createdAt: createdAt ?? this.createdAt,
      updatedAtServer: updatedAtServer ?? this.updatedAtServer,
      deletedAtServer: deletedAtServer ?? this.deletedAtServer,
      deviceId: deviceId ?? this.deviceId,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (templateRemoteId.present) {
      map['template_remote_id'] = Variable<String>(templateRemoteId.value);
    }
    if (titleSnapshot.present) {
      map['title_snapshot'] = Variable<String>(titleSnapshot.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paidAmountCents.present) {
      map['paid_amount_cents'] = Variable<int>(paidAmountCents.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryRemoteId.present) {
      map['category_remote_id'] = Variable<String>(categoryRemoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAtServer.present) {
      map['updated_at_server'] = Variable<int>(updatedAtServer.value);
    }
    if (deletedAtServer.present) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillInstancesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('templateId: $templateId, ')
          ..write('templateRemoteId: $templateRemoteId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidAmountCents: $paidAmountCents, ')
          ..write('paidAt: $paidAt, ')
          ..write('notes: $notes, ')
          ..write('category: $category, ')
          ..write('categoryRemoteId: $categoryRemoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $IncomeSourcesTable extends IncomeSources
    with TableInfo<$IncomeSourcesTable, IncomeSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountCentsMeta =
      const VerificationMeta('amountCents');
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
      'amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _anchorDateMeta =
      const VerificationMeta('anchorDate');
  @override
  late final GeneratedColumn<String> anchorDate = GeneratedColumn<String>(
      'anchor_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtServerMeta =
      const VerificationMeta('updatedAtServer');
  @override
  late final GeneratedColumn<int> updatedAtServer = GeneratedColumn<int>(
      'updated_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtServerMeta =
      const VerificationMeta('deletedAtServer');
  @override
  late final GeneratedColumn<int> deletedAtServer = GeneratedColumn<int>(
      'deleted_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientUpdatedAtMeta =
      const VerificationMeta('clientUpdatedAt');
  @override
  late final GeneratedColumn<int> clientUpdatedAt = GeneratedColumn<int>(
      'client_updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        remoteId,
        householdId,
        name,
        amountCents,
        frequency,
        startDate,
        anchorDate,
        active,
        createdAt,
        updatedAtServer,
        deletedAtServer,
        deviceId,
        clientUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_sources';
  @override
  VerificationContext validateIntegrity(Insertable<IncomeSource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
          _amountCentsMeta,
          amountCents.isAcceptableOrUnknown(
              data['amount_cents']!, _amountCentsMeta));
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('anchor_date')) {
      context.handle(
          _anchorDateMeta,
          anchorDate.isAcceptableOrUnknown(
              data['anchor_date']!, _anchorDateMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at_server')) {
      context.handle(
          _updatedAtServerMeta,
          updatedAtServer.isAcceptableOrUnknown(
              data['updated_at_server']!, _updatedAtServerMeta));
    }
    if (data.containsKey('deleted_at_server')) {
      context.handle(
          _deletedAtServerMeta,
          deletedAtServer.isAcceptableOrUnknown(
              data['deleted_at_server']!, _deletedAtServerMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
          _clientUpdatedAtMeta,
          clientUpdatedAt.isAcceptableOrUnknown(
              data['client_updated_at']!, _clientUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeSource(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      anchorDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}anchor_date']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_server']),
      deletedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at_server']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      clientUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_updated_at']),
    );
  }

  @override
  $IncomeSourcesTable createAlias(String alias) {
    return $IncomeSourcesTable(attachedDatabase, alias);
  }
}

class IncomeSource extends DataClass implements Insertable<IncomeSource> {
  final int id;
  final String profileId;
  final String? remoteId;
  final String? householdId;
  final String name;
  final int amountCents;
  final String frequency;
  final String? startDate;
  final String? anchorDate;
  final bool active;
  final DateTime createdAt;
  final int? updatedAtServer;
  final int? deletedAtServer;
  final String? deviceId;
  final int? clientUpdatedAt;
  const IncomeSource(
      {required this.id,
      required this.profileId,
      this.remoteId,
      this.householdId,
      required this.name,
      required this.amountCents,
      required this.frequency,
      this.startDate,
      this.anchorDate,
      required this.active,
      required this.createdAt,
      this.updatedAtServer,
      this.deletedAtServer,
      this.deviceId,
      this.clientUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || householdId != null) {
      map['household_id'] = Variable<String>(householdId);
    }
    map['name'] = Variable<String>(name);
    map['amount_cents'] = Variable<int>(amountCents);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    if (!nullToAbsent || anchorDate != null) {
      map['anchor_date'] = Variable<String>(anchorDate);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAtServer != null) {
      map['updated_at_server'] = Variable<int>(updatedAtServer);
    }
    if (!nullToAbsent || deletedAtServer != null) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || clientUpdatedAt != null) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt);
    }
    return map;
  }

  IncomeSourcesCompanion toCompanion(bool nullToAbsent) {
    return IncomeSourcesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      householdId: householdId == null && nullToAbsent
          ? const Value.absent()
          : Value(householdId),
      name: Value(name),
      amountCents: Value(amountCents),
      frequency: Value(frequency),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      anchorDate: anchorDate == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorDate),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAtServer: updatedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtServer),
      deletedAtServer: deletedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtServer),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      clientUpdatedAt: clientUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientUpdatedAt),
    );
  }

  factory IncomeSource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeSource(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      householdId: serializer.fromJson<String?>(json['householdId']),
      name: serializer.fromJson<String>(json['name']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      frequency: serializer.fromJson<String>(json['frequency']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      anchorDate: serializer.fromJson<String?>(json['anchorDate']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAtServer: serializer.fromJson<int?>(json['updatedAtServer']),
      deletedAtServer: serializer.fromJson<int?>(json['deletedAtServer']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      clientUpdatedAt: serializer.fromJson<int?>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'householdId': serializer.toJson<String?>(householdId),
      'name': serializer.toJson<String>(name),
      'amountCents': serializer.toJson<int>(amountCents),
      'frequency': serializer.toJson<String>(frequency),
      'startDate': serializer.toJson<String?>(startDate),
      'anchorDate': serializer.toJson<String?>(anchorDate),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAtServer': serializer.toJson<int?>(updatedAtServer),
      'deletedAtServer': serializer.toJson<int?>(deletedAtServer),
      'deviceId': serializer.toJson<String?>(deviceId),
      'clientUpdatedAt': serializer.toJson<int?>(clientUpdatedAt),
    };
  }

  IncomeSource copyWith(
          {int? id,
          String? profileId,
          Value<String?> remoteId = const Value.absent(),
          Value<String?> householdId = const Value.absent(),
          String? name,
          int? amountCents,
          String? frequency,
          Value<String?> startDate = const Value.absent(),
          Value<String?> anchorDate = const Value.absent(),
          bool? active,
          DateTime? createdAt,
          Value<int?> updatedAtServer = const Value.absent(),
          Value<int?> deletedAtServer = const Value.absent(),
          Value<String?> deviceId = const Value.absent(),
          Value<int?> clientUpdatedAt = const Value.absent()}) =>
      IncomeSource(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        householdId: householdId.present ? householdId.value : this.householdId,
        name: name ?? this.name,
        amountCents: amountCents ?? this.amountCents,
        frequency: frequency ?? this.frequency,
        startDate: startDate.present ? startDate.value : this.startDate,
        anchorDate: anchorDate.present ? anchorDate.value : this.anchorDate,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAtServer: updatedAtServer.present
            ? updatedAtServer.value
            : this.updatedAtServer,
        deletedAtServer: deletedAtServer.present
            ? deletedAtServer.value
            : this.deletedAtServer,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        clientUpdatedAt: clientUpdatedAt.present
            ? clientUpdatedAt.value
            : this.clientUpdatedAt,
      );
  IncomeSource copyWithCompanion(IncomeSourcesCompanion data) {
    return IncomeSource(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      name: data.name.present ? data.name.value : this.name,
      amountCents:
          data.amountCents.present ? data.amountCents.value : this.amountCents,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      anchorDate:
          data.anchorDate.present ? data.anchorDate.value : this.anchorDate,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAtServer: data.updatedAtServer.present
          ? data.updatedAtServer.value
          : this.updatedAtServer,
      deletedAtServer: data.deletedAtServer.present
          ? data.deletedAtServer.value
          : this.deletedAtServer,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSource(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('amountCents: $amountCents, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      profileId,
      remoteId,
      householdId,
      name,
      amountCents,
      frequency,
      startDate,
      anchorDate,
      active,
      createdAt,
      updatedAtServer,
      deletedAtServer,
      deviceId,
      clientUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeSource &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.remoteId == this.remoteId &&
          other.householdId == this.householdId &&
          other.name == this.name &&
          other.amountCents == this.amountCents &&
          other.frequency == this.frequency &&
          other.startDate == this.startDate &&
          other.anchorDate == this.anchorDate &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAtServer == this.updatedAtServer &&
          other.deletedAtServer == this.deletedAtServer &&
          other.deviceId == this.deviceId &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class IncomeSourcesCompanion extends UpdateCompanion<IncomeSource> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String?> remoteId;
  final Value<String?> householdId;
  final Value<String> name;
  final Value<int> amountCents;
  final Value<String> frequency;
  final Value<String?> startDate;
  final Value<String?> anchorDate;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<int?> updatedAtServer;
  final Value<int?> deletedAtServer;
  final Value<String?> deviceId;
  final Value<int?> clientUpdatedAt;
  const IncomeSourcesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.name = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.frequency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  IncomeSourcesCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    required String name,
    required int amountCents,
    required String frequency,
    this.startDate = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  })  : name = Value(name),
        amountCents = Value(amountCents),
        frequency = Value(frequency);
  static Insertable<IncomeSource> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? remoteId,
    Expression<String>? householdId,
    Expression<String>? name,
    Expression<int>? amountCents,
    Expression<String>? frequency,
    Expression<String>? startDate,
    Expression<String>? anchorDate,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<int>? updatedAtServer,
    Expression<int>? deletedAtServer,
    Expression<String>? deviceId,
    Expression<int>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (remoteId != null) 'remote_id': remoteId,
      if (householdId != null) 'household_id': householdId,
      if (name != null) 'name': name,
      if (amountCents != null) 'amount_cents': amountCents,
      if (frequency != null) 'frequency': frequency,
      if (startDate != null) 'start_date': startDate,
      if (anchorDate != null) 'anchor_date': anchorDate,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAtServer != null) 'updated_at_server': updatedAtServer,
      if (deletedAtServer != null) 'deleted_at_server': deletedAtServer,
      if (deviceId != null) 'device_id': deviceId,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  IncomeSourcesCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String?>? remoteId,
      Value<String?>? householdId,
      Value<String>? name,
      Value<int>? amountCents,
      Value<String>? frequency,
      Value<String?>? startDate,
      Value<String?>? anchorDate,
      Value<bool>? active,
      Value<DateTime>? createdAt,
      Value<int?>? updatedAtServer,
      Value<int?>? deletedAtServer,
      Value<String?>? deviceId,
      Value<int?>? clientUpdatedAt}) {
    return IncomeSourcesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      remoteId: remoteId ?? this.remoteId,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      amountCents: amountCents ?? this.amountCents,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      anchorDate: anchorDate ?? this.anchorDate,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAtServer: updatedAtServer ?? this.updatedAtServer,
      deletedAtServer: deletedAtServer ?? this.deletedAtServer,
      deviceId: deviceId ?? this.deviceId,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (anchorDate.present) {
      map['anchor_date'] = Variable<String>(anchorDate.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAtServer.present) {
      map['updated_at_server'] = Variable<int>(updatedAtServer.value);
    }
    if (deletedAtServer.present) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourcesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('amountCents: $amountCents, ')
          ..write('frequency: $frequency, ')
          ..write('startDate: $startDate, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $IncomeInstancesTable extends IncomeInstances
    with TableInfo<$IncomeInstancesTable, IncomeInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sourceRemoteIdMeta =
      const VerificationMeta('sourceRemoteId');
  @override
  late final GeneratedColumn<String> sourceRemoteId = GeneratedColumn<String>(
      'source_remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleSnapshotMeta =
      const VerificationMeta('titleSnapshot');
  @override
  late final GeneratedColumn<String> titleSnapshot = GeneratedColumn<String>(
      'title_snapshot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountCentsMeta =
      const VerificationMeta('amountCents');
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
      'amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('expected'));
  static const VerificationMeta _receivedAtMeta =
      const VerificationMeta('receivedAt');
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
      'received_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtServerMeta =
      const VerificationMeta('updatedAtServer');
  @override
  late final GeneratedColumn<int> updatedAtServer = GeneratedColumn<int>(
      'updated_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtServerMeta =
      const VerificationMeta('deletedAtServer');
  @override
  late final GeneratedColumn<int> deletedAtServer = GeneratedColumn<int>(
      'deleted_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientUpdatedAtMeta =
      const VerificationMeta('clientUpdatedAt');
  @override
  late final GeneratedColumn<int> clientUpdatedAt = GeneratedColumn<int>(
      'client_updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        remoteId,
        householdId,
        sourceId,
        sourceRemoteId,
        titleSnapshot,
        amountCents,
        date,
        status,
        receivedAt,
        notes,
        createdAt,
        updatedAtServer,
        deletedAtServer,
        deviceId,
        clientUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_instances';
  @override
  VerificationContext validateIntegrity(Insertable<IncomeInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    }
    if (data.containsKey('source_remote_id')) {
      context.handle(
          _sourceRemoteIdMeta,
          sourceRemoteId.isAcceptableOrUnknown(
              data['source_remote_id']!, _sourceRemoteIdMeta));
    }
    if (data.containsKey('title_snapshot')) {
      context.handle(
          _titleSnapshotMeta,
          titleSnapshot.isAcceptableOrUnknown(
              data['title_snapshot']!, _titleSnapshotMeta));
    } else if (isInserting) {
      context.missing(_titleSnapshotMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
          _amountCentsMeta,
          amountCents.isAcceptableOrUnknown(
              data['amount_cents']!, _amountCentsMeta));
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('received_at')) {
      context.handle(
          _receivedAtMeta,
          receivedAt.isAcceptableOrUnknown(
              data['received_at']!, _receivedAtMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at_server')) {
      context.handle(
          _updatedAtServerMeta,
          updatedAtServer.isAcceptableOrUnknown(
              data['updated_at_server']!, _updatedAtServerMeta));
    }
    if (data.containsKey('deleted_at_server')) {
      context.handle(
          _deletedAtServerMeta,
          deletedAtServer.isAcceptableOrUnknown(
              data['deleted_at_server']!, _deletedAtServerMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
          _clientUpdatedAtMeta,
          clientUpdatedAt.isAcceptableOrUnknown(
              data['client_updated_at']!, _clientUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeInstance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id']),
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_id']),
      sourceRemoteId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}source_remote_id']),
      titleSnapshot: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_snapshot'])!,
      amountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      receivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}received_at']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_server']),
      deletedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at_server']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      clientUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_updated_at']),
    );
  }

  @override
  $IncomeInstancesTable createAlias(String alias) {
    return $IncomeInstancesTable(attachedDatabase, alias);
  }
}

class IncomeInstance extends DataClass implements Insertable<IncomeInstance> {
  final int id;
  final String profileId;
  final String? remoteId;
  final String? householdId;
  final int? sourceId;
  final String? sourceRemoteId;
  final String titleSnapshot;
  final int amountCents;
  final String date;
  final String status;
  final DateTime? receivedAt;
  final String? notes;
  final DateTime createdAt;
  final int? updatedAtServer;
  final int? deletedAtServer;
  final String? deviceId;
  final int? clientUpdatedAt;
  const IncomeInstance(
      {required this.id,
      required this.profileId,
      this.remoteId,
      this.householdId,
      this.sourceId,
      this.sourceRemoteId,
      required this.titleSnapshot,
      required this.amountCents,
      required this.date,
      required this.status,
      this.receivedAt,
      this.notes,
      required this.createdAt,
      this.updatedAtServer,
      this.deletedAtServer,
      this.deviceId,
      this.clientUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || householdId != null) {
      map['household_id'] = Variable<String>(householdId);
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<int>(sourceId);
    }
    if (!nullToAbsent || sourceRemoteId != null) {
      map['source_remote_id'] = Variable<String>(sourceRemoteId);
    }
    map['title_snapshot'] = Variable<String>(titleSnapshot);
    map['amount_cents'] = Variable<int>(amountCents);
    map['date'] = Variable<String>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || receivedAt != null) {
      map['received_at'] = Variable<DateTime>(receivedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAtServer != null) {
      map['updated_at_server'] = Variable<int>(updatedAtServer);
    }
    if (!nullToAbsent || deletedAtServer != null) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || clientUpdatedAt != null) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt);
    }
    return map;
  }

  IncomeInstancesCompanion toCompanion(bool nullToAbsent) {
    return IncomeInstancesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      householdId: householdId == null && nullToAbsent
          ? const Value.absent()
          : Value(householdId),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      sourceRemoteId: sourceRemoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRemoteId),
      titleSnapshot: Value(titleSnapshot),
      amountCents: Value(amountCents),
      date: Value(date),
      status: Value(status),
      receivedAt: receivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAtServer: updatedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtServer),
      deletedAtServer: deletedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtServer),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      clientUpdatedAt: clientUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientUpdatedAt),
    );
  }

  factory IncomeInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeInstance(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      householdId: serializer.fromJson<String?>(json['householdId']),
      sourceId: serializer.fromJson<int?>(json['sourceId']),
      sourceRemoteId: serializer.fromJson<String?>(json['sourceRemoteId']),
      titleSnapshot: serializer.fromJson<String>(json['titleSnapshot']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      receivedAt: serializer.fromJson<DateTime?>(json['receivedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAtServer: serializer.fromJson<int?>(json['updatedAtServer']),
      deletedAtServer: serializer.fromJson<int?>(json['deletedAtServer']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      clientUpdatedAt: serializer.fromJson<int?>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'householdId': serializer.toJson<String?>(householdId),
      'sourceId': serializer.toJson<int?>(sourceId),
      'sourceRemoteId': serializer.toJson<String?>(sourceRemoteId),
      'titleSnapshot': serializer.toJson<String>(titleSnapshot),
      'amountCents': serializer.toJson<int>(amountCents),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'receivedAt': serializer.toJson<DateTime?>(receivedAt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAtServer': serializer.toJson<int?>(updatedAtServer),
      'deletedAtServer': serializer.toJson<int?>(deletedAtServer),
      'deviceId': serializer.toJson<String?>(deviceId),
      'clientUpdatedAt': serializer.toJson<int?>(clientUpdatedAt),
    };
  }

  IncomeInstance copyWith(
          {int? id,
          String? profileId,
          Value<String?> remoteId = const Value.absent(),
          Value<String?> householdId = const Value.absent(),
          Value<int?> sourceId = const Value.absent(),
          Value<String?> sourceRemoteId = const Value.absent(),
          String? titleSnapshot,
          int? amountCents,
          String? date,
          String? status,
          Value<DateTime?> receivedAt = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          Value<int?> updatedAtServer = const Value.absent(),
          Value<int?> deletedAtServer = const Value.absent(),
          Value<String?> deviceId = const Value.absent(),
          Value<int?> clientUpdatedAt = const Value.absent()}) =>
      IncomeInstance(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        householdId: householdId.present ? householdId.value : this.householdId,
        sourceId: sourceId.present ? sourceId.value : this.sourceId,
        sourceRemoteId:
            sourceRemoteId.present ? sourceRemoteId.value : this.sourceRemoteId,
        titleSnapshot: titleSnapshot ?? this.titleSnapshot,
        amountCents: amountCents ?? this.amountCents,
        date: date ?? this.date,
        status: status ?? this.status,
        receivedAt: receivedAt.present ? receivedAt.value : this.receivedAt,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAtServer: updatedAtServer.present
            ? updatedAtServer.value
            : this.updatedAtServer,
        deletedAtServer: deletedAtServer.present
            ? deletedAtServer.value
            : this.deletedAtServer,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        clientUpdatedAt: clientUpdatedAt.present
            ? clientUpdatedAt.value
            : this.clientUpdatedAt,
      );
  IncomeInstance copyWithCompanion(IncomeInstancesCompanion data) {
    return IncomeInstance(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      sourceRemoteId: data.sourceRemoteId.present
          ? data.sourceRemoteId.value
          : this.sourceRemoteId,
      titleSnapshot: data.titleSnapshot.present
          ? data.titleSnapshot.value
          : this.titleSnapshot,
      amountCents:
          data.amountCents.present ? data.amountCents.value : this.amountCents,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      receivedAt:
          data.receivedAt.present ? data.receivedAt.value : this.receivedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAtServer: data.updatedAtServer.present
          ? data.updatedAtServer.value
          : this.updatedAtServer,
      deletedAtServer: data.deletedAtServer.present
          ? data.deletedAtServer.value
          : this.deletedAtServer,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeInstance(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('sourceId: $sourceId, ')
          ..write('sourceRemoteId: $sourceRemoteId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      profileId,
      remoteId,
      householdId,
      sourceId,
      sourceRemoteId,
      titleSnapshot,
      amountCents,
      date,
      status,
      receivedAt,
      notes,
      createdAt,
      updatedAtServer,
      deletedAtServer,
      deviceId,
      clientUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeInstance &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.remoteId == this.remoteId &&
          other.householdId == this.householdId &&
          other.sourceId == this.sourceId &&
          other.sourceRemoteId == this.sourceRemoteId &&
          other.titleSnapshot == this.titleSnapshot &&
          other.amountCents == this.amountCents &&
          other.date == this.date &&
          other.status == this.status &&
          other.receivedAt == this.receivedAt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAtServer == this.updatedAtServer &&
          other.deletedAtServer == this.deletedAtServer &&
          other.deviceId == this.deviceId &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class IncomeInstancesCompanion extends UpdateCompanion<IncomeInstance> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String?> remoteId;
  final Value<String?> householdId;
  final Value<int?> sourceId;
  final Value<String?> sourceRemoteId;
  final Value<String> titleSnapshot;
  final Value<int> amountCents;
  final Value<String> date;
  final Value<String> status;
  final Value<DateTime?> receivedAt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int?> updatedAtServer;
  final Value<int?> deletedAtServer;
  final Value<String?> deviceId;
  final Value<int?> clientUpdatedAt;
  const IncomeInstancesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.sourceRemoteId = const Value.absent(),
    this.titleSnapshot = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  IncomeInstancesCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.sourceRemoteId = const Value.absent(),
    required String titleSnapshot,
    required int amountCents,
    required String date,
    this.status = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  })  : titleSnapshot = Value(titleSnapshot),
        amountCents = Value(amountCents),
        date = Value(date);
  static Insertable<IncomeInstance> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? remoteId,
    Expression<String>? householdId,
    Expression<int>? sourceId,
    Expression<String>? sourceRemoteId,
    Expression<String>? titleSnapshot,
    Expression<int>? amountCents,
    Expression<String>? date,
    Expression<String>? status,
    Expression<DateTime>? receivedAt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? updatedAtServer,
    Expression<int>? deletedAtServer,
    Expression<String>? deviceId,
    Expression<int>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (remoteId != null) 'remote_id': remoteId,
      if (householdId != null) 'household_id': householdId,
      if (sourceId != null) 'source_id': sourceId,
      if (sourceRemoteId != null) 'source_remote_id': sourceRemoteId,
      if (titleSnapshot != null) 'title_snapshot': titleSnapshot,
      if (amountCents != null) 'amount_cents': amountCents,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (receivedAt != null) 'received_at': receivedAt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAtServer != null) 'updated_at_server': updatedAtServer,
      if (deletedAtServer != null) 'deleted_at_server': deletedAtServer,
      if (deviceId != null) 'device_id': deviceId,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  IncomeInstancesCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String?>? remoteId,
      Value<String?>? householdId,
      Value<int?>? sourceId,
      Value<String?>? sourceRemoteId,
      Value<String>? titleSnapshot,
      Value<int>? amountCents,
      Value<String>? date,
      Value<String>? status,
      Value<DateTime?>? receivedAt,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int?>? updatedAtServer,
      Value<int?>? deletedAtServer,
      Value<String?>? deviceId,
      Value<int?>? clientUpdatedAt}) {
    return IncomeInstancesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      remoteId: remoteId ?? this.remoteId,
      householdId: householdId ?? this.householdId,
      sourceId: sourceId ?? this.sourceId,
      sourceRemoteId: sourceRemoteId ?? this.sourceRemoteId,
      titleSnapshot: titleSnapshot ?? this.titleSnapshot,
      amountCents: amountCents ?? this.amountCents,
      date: date ?? this.date,
      status: status ?? this.status,
      receivedAt: receivedAt ?? this.receivedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAtServer: updatedAtServer ?? this.updatedAtServer,
      deletedAtServer: deletedAtServer ?? this.deletedAtServer,
      deviceId: deviceId ?? this.deviceId,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (sourceRemoteId.present) {
      map['source_remote_id'] = Variable<String>(sourceRemoteId.value);
    }
    if (titleSnapshot.present) {
      map['title_snapshot'] = Variable<String>(titleSnapshot.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAtServer.present) {
      map['updated_at_server'] = Variable<int>(updatedAtServer.value);
    }
    if (deletedAtServer.present) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeInstancesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('sourceId: $sourceId, ')
          ..write('sourceRemoteId: $sourceRemoteId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _householdIdMeta =
      const VerificationMeta('householdId');
  @override
  late final GeneratedColumn<String> householdId = GeneratedColumn<String>(
      'household_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtServerMeta =
      const VerificationMeta('updatedAtServer');
  @override
  late final GeneratedColumn<int> updatedAtServer = GeneratedColumn<int>(
      'updated_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deletedAtServerMeta =
      const VerificationMeta('deletedAtServer');
  @override
  late final GeneratedColumn<int> deletedAtServer = GeneratedColumn<int>(
      'deleted_at_server', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clientUpdatedAtMeta =
      const VerificationMeta('clientUpdatedAt');
  @override
  late final GeneratedColumn<int> clientUpdatedAt = GeneratedColumn<int>(
      'client_updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        remoteId,
        householdId,
        name,
        color,
        icon,
        sortOrder,
        updatedAtServer,
        deletedAtServer,
        deviceId,
        clientUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('household_id')) {
      context.handle(
          _householdIdMeta,
          householdId.isAcceptableOrUnknown(
              data['household_id']!, _householdIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('updated_at_server')) {
      context.handle(
          _updatedAtServerMeta,
          updatedAtServer.isAcceptableOrUnknown(
              data['updated_at_server']!, _updatedAtServerMeta));
    }
    if (data.containsKey('deleted_at_server')) {
      context.handle(
          _deletedAtServerMeta,
          deletedAtServer.isAcceptableOrUnknown(
              data['deleted_at_server']!, _deletedAtServerMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
          _clientUpdatedAtMeta,
          clientUpdatedAt.isAcceptableOrUnknown(
              data['client_updated_at']!, _clientUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      householdId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}household_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      updatedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at_server']),
      deletedAtServer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at_server']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
      clientUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_updated_at']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String profileId;
  final String? remoteId;
  final String? householdId;
  final String name;
  final String? color;
  final String? icon;
  final int sortOrder;
  final int? updatedAtServer;
  final int? deletedAtServer;
  final String? deviceId;
  final int? clientUpdatedAt;
  const Category(
      {required this.id,
      required this.profileId,
      this.remoteId,
      this.householdId,
      required this.name,
      this.color,
      this.icon,
      required this.sortOrder,
      this.updatedAtServer,
      this.deletedAtServer,
      this.deviceId,
      this.clientUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || householdId != null) {
      map['household_id'] = Variable<String>(householdId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || updatedAtServer != null) {
      map['updated_at_server'] = Variable<int>(updatedAtServer);
    }
    if (!nullToAbsent || deletedAtServer != null) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || clientUpdatedAt != null) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      householdId: householdId == null && nullToAbsent
          ? const Value.absent()
          : Value(householdId),
      name: Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      sortOrder: Value(sortOrder),
      updatedAtServer: updatedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtServer),
      deletedAtServer: deletedAtServer == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtServer),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      clientUpdatedAt: clientUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientUpdatedAt),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      householdId: serializer.fromJson<String?>(json['householdId']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      updatedAtServer: serializer.fromJson<int?>(json['updatedAtServer']),
      deletedAtServer: serializer.fromJson<int?>(json['deletedAtServer']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      clientUpdatedAt: serializer.fromJson<int?>(json['clientUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'householdId': serializer.toJson<String?>(householdId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'icon': serializer.toJson<String?>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'updatedAtServer': serializer.toJson<int?>(updatedAtServer),
      'deletedAtServer': serializer.toJson<int?>(deletedAtServer),
      'deviceId': serializer.toJson<String?>(deviceId),
      'clientUpdatedAt': serializer.toJson<int?>(clientUpdatedAt),
    };
  }

  Category copyWith(
          {int? id,
          String? profileId,
          Value<String?> remoteId = const Value.absent(),
          Value<String?> householdId = const Value.absent(),
          String? name,
          Value<String?> color = const Value.absent(),
          Value<String?> icon = const Value.absent(),
          int? sortOrder,
          Value<int?> updatedAtServer = const Value.absent(),
          Value<int?> deletedAtServer = const Value.absent(),
          Value<String?> deviceId = const Value.absent(),
          Value<int?> clientUpdatedAt = const Value.absent()}) =>
      Category(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        householdId: householdId.present ? householdId.value : this.householdId,
        name: name ?? this.name,
        color: color.present ? color.value : this.color,
        icon: icon.present ? icon.value : this.icon,
        sortOrder: sortOrder ?? this.sortOrder,
        updatedAtServer: updatedAtServer.present
            ? updatedAtServer.value
            : this.updatedAtServer,
        deletedAtServer: deletedAtServer.present
            ? deletedAtServer.value
            : this.deletedAtServer,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
        clientUpdatedAt: clientUpdatedAt.present
            ? clientUpdatedAt.value
            : this.clientUpdatedAt,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      householdId:
          data.householdId.present ? data.householdId.value : this.householdId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAtServer: data.updatedAtServer.present
          ? data.updatedAtServer.value
          : this.updatedAtServer,
      deletedAtServer: data.deletedAtServer.present
          ? data.deletedAtServer.value
          : this.deletedAtServer,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      profileId,
      remoteId,
      householdId,
      name,
      color,
      icon,
      sortOrder,
      updatedAtServer,
      deletedAtServer,
      deviceId,
      clientUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.remoteId == this.remoteId &&
          other.householdId == this.householdId &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder &&
          other.updatedAtServer == this.updatedAtServer &&
          other.deletedAtServer == this.deletedAtServer &&
          other.deviceId == this.deviceId &&
          other.clientUpdatedAt == this.clientUpdatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String?> remoteId;
  final Value<String?> householdId;
  final Value<String> name;
  final Value<String?> color;
  final Value<String?> icon;
  final Value<int> sortOrder;
  final Value<int?> updatedAtServer;
  final Value<int?> deletedAtServer;
  final Value<String?> deviceId;
  final Value<int?> clientUpdatedAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.householdId = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAtServer = const Value.absent(),
    this.deletedAtServer = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? remoteId,
    Expression<String>? householdId,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<int>? sortOrder,
    Expression<int>? updatedAtServer,
    Expression<int>? deletedAtServer,
    Expression<String>? deviceId,
    Expression<int>? clientUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (remoteId != null) 'remote_id': remoteId,
      if (householdId != null) 'household_id': householdId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAtServer != null) 'updated_at_server': updatedAtServer,
      if (deletedAtServer != null) 'deleted_at_server': deletedAtServer,
      if (deviceId != null) 'device_id': deviceId,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String?>? remoteId,
      Value<String?>? householdId,
      Value<String>? name,
      Value<String?>? color,
      Value<String?>? icon,
      Value<int>? sortOrder,
      Value<int?>? updatedAtServer,
      Value<int?>? deletedAtServer,
      Value<String?>? deviceId,
      Value<int?>? clientUpdatedAt}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      remoteId: remoteId ?? this.remoteId,
      householdId: householdId ?? this.householdId,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAtServer: updatedAtServer ?? this.updatedAtServer,
      deletedAtServer: deletedAtServer ?? this.deletedAtServer,
      deviceId: deviceId ?? this.deviceId,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (householdId.present) {
      map['household_id'] = Variable<String>(householdId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAtServer.present) {
      map['updated_at_server'] = Variable<int>(updatedAtServer.value);
    }
    if (deletedAtServer.present) {
      map['deleted_at_server'] = Variable<int>(deletedAtServer.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<int>(clientUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('remoteId: $remoteId, ')
          ..write('householdId: $householdId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAtServer: $updatedAtServer, ')
          ..write('deletedAtServer: $deletedAtServer, ')
          ..write('deviceId: $deviceId, ')
          ..write('clientUpdatedAt: $clientUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncSettingsTable extends SyncSettings
    with TableInfo<$SyncSettingsTable, SyncSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _useRemoteMeta =
      const VerificationMeta('useRemote');
  @override
  late final GeneratedColumn<bool> useRemote = GeneratedColumn<bool>(
      'use_remote', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("use_remote" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _baseUrlMeta =
      const VerificationMeta('baseUrl');
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
      'base_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
      'api_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('local_only'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastSyncServerMsMeta =
      const VerificationMeta('lastSyncServerMs');
  @override
  late final GeneratedColumn<int> lastSyncServerMs = GeneratedColumn<int>(
      'last_sync_server_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        useRemote,
        baseUrl,
        apiKey,
        mode,
        updatedAt,
        lastSyncServerMs,
        deviceId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_settings';
  @override
  VerificationContext validateIntegrity(Insertable<SyncSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('use_remote')) {
      context.handle(_useRemoteMeta,
          useRemote.isAcceptableOrUnknown(data['use_remote']!, _useRemoteMeta));
    }
    if (data.containsKey('base_url')) {
      context.handle(_baseUrlMeta,
          baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta));
    }
    if (data.containsKey('api_key')) {
      context.handle(_apiKeyMeta,
          apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta));
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_sync_server_ms')) {
      context.handle(
          _lastSyncServerMsMeta,
          lastSyncServerMs.isAcceptableOrUnknown(
              data['last_sync_server_ms']!, _lastSyncServerMsMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      useRemote: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_remote'])!,
      baseUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}base_url']),
      apiKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}api_key']),
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      lastSyncServerMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}last_sync_server_ms'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id']),
    );
  }

  @override
  $SyncSettingsTable createAlias(String alias) {
    return $SyncSettingsTable(attachedDatabase, alias);
  }
}

class SyncSetting extends DataClass implements Insertable<SyncSetting> {
  final int id;
  final String profileId;
  final bool useRemote;
  final String? baseUrl;
  final String? apiKey;
  final String mode;
  final DateTime updatedAt;
  final int lastSyncServerMs;
  final String? deviceId;
  const SyncSetting(
      {required this.id,
      required this.profileId,
      required this.useRemote,
      this.baseUrl,
      this.apiKey,
      required this.mode,
      required this.updatedAt,
      required this.lastSyncServerMs,
      this.deviceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['use_remote'] = Variable<bool>(useRemote);
    if (!nullToAbsent || baseUrl != null) {
      map['base_url'] = Variable<String>(baseUrl);
    }
    if (!nullToAbsent || apiKey != null) {
      map['api_key'] = Variable<String>(apiKey);
    }
    map['mode'] = Variable<String>(mode);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['last_sync_server_ms'] = Variable<int>(lastSyncServerMs);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    return map;
  }

  SyncSettingsCompanion toCompanion(bool nullToAbsent) {
    return SyncSettingsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      useRemote: Value(useRemote),
      baseUrl: baseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(baseUrl),
      apiKey:
          apiKey == null && nullToAbsent ? const Value.absent() : Value(apiKey),
      mode: Value(mode),
      updatedAt: Value(updatedAt),
      lastSyncServerMs: Value(lastSyncServerMs),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
    );
  }

  factory SyncSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncSetting(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      useRemote: serializer.fromJson<bool>(json['useRemote']),
      baseUrl: serializer.fromJson<String?>(json['baseUrl']),
      apiKey: serializer.fromJson<String?>(json['apiKey']),
      mode: serializer.fromJson<String>(json['mode']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncServerMs: serializer.fromJson<int>(json['lastSyncServerMs']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'useRemote': serializer.toJson<bool>(useRemote),
      'baseUrl': serializer.toJson<String?>(baseUrl),
      'apiKey': serializer.toJson<String?>(apiKey),
      'mode': serializer.toJson<String>(mode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncServerMs': serializer.toJson<int>(lastSyncServerMs),
      'deviceId': serializer.toJson<String?>(deviceId),
    };
  }

  SyncSetting copyWith(
          {int? id,
          String? profileId,
          bool? useRemote,
          Value<String?> baseUrl = const Value.absent(),
          Value<String?> apiKey = const Value.absent(),
          String? mode,
          DateTime? updatedAt,
          int? lastSyncServerMs,
          Value<String?> deviceId = const Value.absent()}) =>
      SyncSetting(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        useRemote: useRemote ?? this.useRemote,
        baseUrl: baseUrl.present ? baseUrl.value : this.baseUrl,
        apiKey: apiKey.present ? apiKey.value : this.apiKey,
        mode: mode ?? this.mode,
        updatedAt: updatedAt ?? this.updatedAt,
        lastSyncServerMs: lastSyncServerMs ?? this.lastSyncServerMs,
        deviceId: deviceId.present ? deviceId.value : this.deviceId,
      );
  SyncSetting copyWithCompanion(SyncSettingsCompanion data) {
    return SyncSetting(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      useRemote: data.useRemote.present ? data.useRemote.value : this.useRemote,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      mode: data.mode.present ? data.mode.value : this.mode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncServerMs: data.lastSyncServerMs.present
          ? data.lastSyncServerMs.value
          : this.lastSyncServerMs,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncSetting(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('useRemote: $useRemote, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('mode: $mode, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncServerMs: $lastSyncServerMs, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileId, useRemote, baseUrl, apiKey,
      mode, updatedAt, lastSyncServerMs, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncSetting &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.useRemote == this.useRemote &&
          other.baseUrl == this.baseUrl &&
          other.apiKey == this.apiKey &&
          other.mode == this.mode &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncServerMs == this.lastSyncServerMs &&
          other.deviceId == this.deviceId);
}

class SyncSettingsCompanion extends UpdateCompanion<SyncSetting> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<bool> useRemote;
  final Value<String?> baseUrl;
  final Value<String?> apiKey;
  final Value<String> mode;
  final Value<DateTime> updatedAt;
  final Value<int> lastSyncServerMs;
  final Value<String?> deviceId;
  const SyncSettingsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.useRemote = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.mode = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncServerMs = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  SyncSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.useRemote = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.mode = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncServerMs = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  static Insertable<SyncSetting> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<bool>? useRemote,
    Expression<String>? baseUrl,
    Expression<String>? apiKey,
    Expression<String>? mode,
    Expression<DateTime>? updatedAt,
    Expression<int>? lastSyncServerMs,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (useRemote != null) 'use_remote': useRemote,
      if (baseUrl != null) 'base_url': baseUrl,
      if (apiKey != null) 'api_key': apiKey,
      if (mode != null) 'mode': mode,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncServerMs != null) 'last_sync_server_ms': lastSyncServerMs,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  SyncSettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<bool>? useRemote,
      Value<String?>? baseUrl,
      Value<String?>? apiKey,
      Value<String>? mode,
      Value<DateTime>? updatedAt,
      Value<int>? lastSyncServerMs,
      Value<String?>? deviceId}) {
    return SyncSettingsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      useRemote: useRemote ?? this.useRemote,
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      mode: mode ?? this.mode,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncServerMs: lastSyncServerMs ?? this.lastSyncServerMs,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (useRemote.present) {
      map['use_remote'] = Variable<bool>(useRemote.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncServerMs.present) {
      map['last_sync_server_ms'] = Variable<int>(lastSyncServerMs.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncSettingsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('useRemote: $useRemote, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('apiKey: $apiKey, ')
          ..write('mode: $mode, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncServerMs: $lastSyncServerMs, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $OutboxEntriesTable extends OutboxEntries
    with TableInfo<$OutboxEntriesTable, OutboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('remote'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _opMeta = const VerificationMeta('op');
  @override
  late final GeneratedColumn<String> op = GeneratedColumn<String>(
      'op', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _queuedAtMeta =
      const VerificationMeta('queuedAt');
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
      'queued_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, profileId, entityType, entityId, op, payloadJson, queuedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_entries';
  @override
  VerificationContext validateIntegrity(Insertable<OutboxEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('op')) {
      context.handle(_opMeta, op.isAcceptableOrUnknown(data['op']!, _opMeta));
    } else if (isInserting) {
      context.missing(_opMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    }
    if (data.containsKey('queued_at')) {
      context.handle(_queuedAtMeta,
          queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      op: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}op'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json']),
      queuedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}queued_at'])!,
    );
  }

  @override
  $OutboxEntriesTable createAlias(String alias) {
    return $OutboxEntriesTable(attachedDatabase, alias);
  }
}

class OutboxEntry extends DataClass implements Insertable<OutboxEntry> {
  final int id;
  final String profileId;
  final String entityType;
  final String entityId;
  final String op;
  final String? payloadJson;
  final DateTime queuedAt;
  const OutboxEntry(
      {required this.id,
      required this.profileId,
      required this.entityType,
      required this.entityId,
      required this.op,
      this.payloadJson,
      required this.queuedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['op'] = Variable<String>(op);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    map['queued_at'] = Variable<DateTime>(queuedAt);
    return map;
  }

  OutboxEntriesCompanion toCompanion(bool nullToAbsent) {
    return OutboxEntriesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      op: Value(op),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
      queuedAt: Value(queuedAt),
    );
  }

  factory OutboxEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxEntry(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      op: serializer.fromJson<String>(json['op']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
      queuedAt: serializer.fromJson<DateTime>(json['queuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'op': serializer.toJson<String>(op),
      'payloadJson': serializer.toJson<String?>(payloadJson),
      'queuedAt': serializer.toJson<DateTime>(queuedAt),
    };
  }

  OutboxEntry copyWith(
          {int? id,
          String? profileId,
          String? entityType,
          String? entityId,
          String? op,
          Value<String?> payloadJson = const Value.absent(),
          DateTime? queuedAt}) =>
      OutboxEntry(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        op: op ?? this.op,
        payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
        queuedAt: queuedAt ?? this.queuedAt,
      );
  OutboxEntry copyWithCompanion(OutboxEntriesCompanion data) {
    return OutboxEntry(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      op: data.op.present ? data.op.value : this.op,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntry(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('op: $op, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('queuedAt: $queuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, profileId, entityType, entityId, op, payloadJson, queuedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxEntry &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.op == this.op &&
          other.payloadJson == this.payloadJson &&
          other.queuedAt == this.queuedAt);
}

class OutboxEntriesCompanion extends UpdateCompanion<OutboxEntry> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> op;
  final Value<String?> payloadJson;
  final Value<DateTime> queuedAt;
  const OutboxEntriesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.op = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.queuedAt = const Value.absent(),
  });
  OutboxEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    required String entityType,
    required String entityId,
    required String op,
    this.payloadJson = const Value.absent(),
    this.queuedAt = const Value.absent(),
  })  : entityType = Value(entityType),
        entityId = Value(entityId),
        op = Value(op);
  static Insertable<OutboxEntry> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? op,
    Expression<String>? payloadJson,
    Expression<DateTime>? queuedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (op != null) 'op': op,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (queuedAt != null) 'queued_at': queuedAt,
    });
  }

  OutboxEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? op,
      Value<String?>? payloadJson,
      Value<DateTime>? queuedAt}) {
    return OutboxEntriesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      op: op ?? this.op,
      payloadJson: payloadJson ?? this.payloadJson,
      queuedAt: queuedAt ?? this.queuedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (op.present) {
      map['op'] = Variable<String>(op.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntriesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('op: $op, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('queuedAt: $queuedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BillTemplatesTable billTemplates = $BillTemplatesTable(this);
  late final $BillInstancesTable billInstances = $BillInstancesTable(this);
  late final $IncomeSourcesTable incomeSources = $IncomeSourcesTable(this);
  late final $IncomeInstancesTable incomeInstances =
      $IncomeInstancesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $SyncSettingsTable syncSettings = $SyncSettingsTable(this);
  late final $OutboxEntriesTable outboxEntries = $OutboxEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        billTemplates,
        billInstances,
        incomeSources,
        incomeInstances,
        categories,
        syncSettings,
        outboxEntries
      ];
}

typedef $$BillTemplatesTableCreateCompanionBuilder = BillTemplatesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  required String name,
  Value<String?> category,
  Value<String?> categoryRemoteId,
  required int defaultAmountCents,
  Value<String?> startDate,
  Value<bool> active,
  Value<String?> recurrenceRule,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});
typedef $$BillTemplatesTableUpdateCompanionBuilder = BillTemplatesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<String> name,
  Value<String?> category,
  Value<String?> categoryRemoteId,
  Value<int> defaultAmountCents,
  Value<String?> startDate,
  Value<bool> active,
  Value<String?> recurrenceRule,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});

class $$BillTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $BillTemplatesTable> {
  $$BillTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryRemoteId => $composableBuilder(
      column: $table.categoryRemoteId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultAmountCents => $composableBuilder(
      column: $table.defaultAmountCents,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurrenceRule => $composableBuilder(
      column: $table.recurrenceRule,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnFilters(column));
}

class $$BillTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $BillTemplatesTable> {
  $$BillTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryRemoteId => $composableBuilder(
      column: $table.categoryRemoteId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultAmountCents => $composableBuilder(
      column: $table.defaultAmountCents,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurrenceRule => $composableBuilder(
      column: $table.recurrenceRule,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$BillTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillTemplatesTable> {
  $$BillTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get categoryRemoteId => $composableBuilder(
      column: $table.categoryRemoteId, builder: (column) => column);

  GeneratedColumn<int> get defaultAmountCents => $composableBuilder(
      column: $table.defaultAmountCents, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get recurrenceRule => $composableBuilder(
      column: $table.recurrenceRule, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer, builder: (column) => column);

  GeneratedColumn<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt, builder: (column) => column);
}

class $$BillTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BillTemplatesTable,
    BillTemplate,
    $$BillTemplatesTableFilterComposer,
    $$BillTemplatesTableOrderingComposer,
    $$BillTemplatesTableAnnotationComposer,
    $$BillTemplatesTableCreateCompanionBuilder,
    $$BillTemplatesTableUpdateCompanionBuilder,
    (
      BillTemplate,
      BaseReferences<_$AppDatabase, $BillTemplatesTable, BillTemplate>
    ),
    BillTemplate,
    PrefetchHooks Function()> {
  $$BillTemplatesTableTableManager(_$AppDatabase db, $BillTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> categoryRemoteId = const Value.absent(),
            Value<int> defaultAmountCents = const Value.absent(),
            Value<String?> startDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<String?> recurrenceRule = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              BillTemplatesCompanion(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            name: name,
            category: category,
            categoryRemoteId: categoryRemoteId,
            defaultAmountCents: defaultAmountCents,
            startDate: startDate,
            active: active,
            recurrenceRule: recurrenceRule,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            required String name,
            Value<String?> category = const Value.absent(),
            Value<String?> categoryRemoteId = const Value.absent(),
            required int defaultAmountCents,
            Value<String?> startDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<String?> recurrenceRule = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              BillTemplatesCompanion.insert(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            name: name,
            category: category,
            categoryRemoteId: categoryRemoteId,
            defaultAmountCents: defaultAmountCents,
            startDate: startDate,
            active: active,
            recurrenceRule: recurrenceRule,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BillTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BillTemplatesTable,
    BillTemplate,
    $$BillTemplatesTableFilterComposer,
    $$BillTemplatesTableOrderingComposer,
    $$BillTemplatesTableAnnotationComposer,
    $$BillTemplatesTableCreateCompanionBuilder,
    $$BillTemplatesTableUpdateCompanionBuilder,
    (
      BillTemplate,
      BaseReferences<_$AppDatabase, $BillTemplatesTable, BillTemplate>
    ),
    BillTemplate,
    PrefetchHooks Function()>;
typedef $$BillInstancesTableCreateCompanionBuilder = BillInstancesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<int?> templateId,
  Value<String?> templateRemoteId,
  required String titleSnapshot,
  required int amountCents,
  required String dueDate,
  Value<String> status,
  Value<int?> paidAmountCents,
  Value<DateTime?> paidAt,
  Value<String?> notes,
  Value<String?> category,
  Value<String?> categoryRemoteId,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});
typedef $$BillInstancesTableUpdateCompanionBuilder = BillInstancesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<int?> templateId,
  Value<String?> templateRemoteId,
  Value<String> titleSnapshot,
  Value<int> amountCents,
  Value<String> dueDate,
  Value<String> status,
  Value<int?> paidAmountCents,
  Value<DateTime?> paidAt,
  Value<String?> notes,
  Value<String?> category,
  Value<String?> categoryRemoteId,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});

class $$BillInstancesTableFilterComposer
    extends Composer<_$AppDatabase, $BillInstancesTable> {
  $$BillInstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get templateRemoteId => $composableBuilder(
      column: $table.templateRemoteId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleSnapshot => $composableBuilder(
      column: $table.titleSnapshot, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paidAmountCents => $composableBuilder(
      column: $table.paidAmountCents,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryRemoteId => $composableBuilder(
      column: $table.categoryRemoteId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnFilters(column));
}

class $$BillInstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $BillInstancesTable> {
  $$BillInstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get templateRemoteId => $composableBuilder(
      column: $table.templateRemoteId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleSnapshot => $composableBuilder(
      column: $table.titleSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paidAmountCents => $composableBuilder(
      column: $table.paidAmountCents,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryRemoteId => $composableBuilder(
      column: $table.categoryRemoteId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$BillInstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillInstancesTable> {
  $$BillInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => column);

  GeneratedColumn<String> get templateRemoteId => $composableBuilder(
      column: $table.templateRemoteId, builder: (column) => column);

  GeneratedColumn<String> get titleSnapshot => $composableBuilder(
      column: $table.titleSnapshot, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get paidAmountCents => $composableBuilder(
      column: $table.paidAmountCents, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get categoryRemoteId => $composableBuilder(
      column: $table.categoryRemoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer, builder: (column) => column);

  GeneratedColumn<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt, builder: (column) => column);
}

class $$BillInstancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BillInstancesTable,
    BillInstance,
    $$BillInstancesTableFilterComposer,
    $$BillInstancesTableOrderingComposer,
    $$BillInstancesTableAnnotationComposer,
    $$BillInstancesTableCreateCompanionBuilder,
    $$BillInstancesTableUpdateCompanionBuilder,
    (
      BillInstance,
      BaseReferences<_$AppDatabase, $BillInstancesTable, BillInstance>
    ),
    BillInstance,
    PrefetchHooks Function()> {
  $$BillInstancesTableTableManager(_$AppDatabase db, $BillInstancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillInstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<int?> templateId = const Value.absent(),
            Value<String?> templateRemoteId = const Value.absent(),
            Value<String> titleSnapshot = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<String> dueDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> paidAmountCents = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> categoryRemoteId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              BillInstancesCompanion(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            templateId: templateId,
            templateRemoteId: templateRemoteId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            dueDate: dueDate,
            status: status,
            paidAmountCents: paidAmountCents,
            paidAt: paidAt,
            notes: notes,
            category: category,
            categoryRemoteId: categoryRemoteId,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<int?> templateId = const Value.absent(),
            Value<String?> templateRemoteId = const Value.absent(),
            required String titleSnapshot,
            required int amountCents,
            required String dueDate,
            Value<String> status = const Value.absent(),
            Value<int?> paidAmountCents = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> categoryRemoteId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              BillInstancesCompanion.insert(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            templateId: templateId,
            templateRemoteId: templateRemoteId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            dueDate: dueDate,
            status: status,
            paidAmountCents: paidAmountCents,
            paidAt: paidAt,
            notes: notes,
            category: category,
            categoryRemoteId: categoryRemoteId,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BillInstancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BillInstancesTable,
    BillInstance,
    $$BillInstancesTableFilterComposer,
    $$BillInstancesTableOrderingComposer,
    $$BillInstancesTableAnnotationComposer,
    $$BillInstancesTableCreateCompanionBuilder,
    $$BillInstancesTableUpdateCompanionBuilder,
    (
      BillInstance,
      BaseReferences<_$AppDatabase, $BillInstancesTable, BillInstance>
    ),
    BillInstance,
    PrefetchHooks Function()>;
typedef $$IncomeSourcesTableCreateCompanionBuilder = IncomeSourcesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  required String name,
  required int amountCents,
  required String frequency,
  Value<String?> startDate,
  Value<String?> anchorDate,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});
typedef $$IncomeSourcesTableUpdateCompanionBuilder = IncomeSourcesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<String> name,
  Value<int> amountCents,
  Value<String> frequency,
  Value<String?> startDate,
  Value<String?> anchorDate,
  Value<bool> active,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});

class $$IncomeSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnFilters(column));
}

class $$IncomeSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$IncomeSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer, builder: (column) => column);

  GeneratedColumn<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt, builder: (column) => column);
}

class $$IncomeSourcesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IncomeSourcesTable,
    IncomeSource,
    $$IncomeSourcesTableFilterComposer,
    $$IncomeSourcesTableOrderingComposer,
    $$IncomeSourcesTableAnnotationComposer,
    $$IncomeSourcesTableCreateCompanionBuilder,
    $$IncomeSourcesTableUpdateCompanionBuilder,
    (
      IncomeSource,
      BaseReferences<_$AppDatabase, $IncomeSourcesTable, IncomeSource>
    ),
    IncomeSource,
    PrefetchHooks Function()> {
  $$IncomeSourcesTableTableManager(_$AppDatabase db, $IncomeSourcesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<String?> startDate = const Value.absent(),
            Value<String?> anchorDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              IncomeSourcesCompanion(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            name: name,
            amountCents: amountCents,
            frequency: frequency,
            startDate: startDate,
            anchorDate: anchorDate,
            active: active,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            required String name,
            required int amountCents,
            required String frequency,
            Value<String?> startDate = const Value.absent(),
            Value<String?> anchorDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              IncomeSourcesCompanion.insert(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            name: name,
            amountCents: amountCents,
            frequency: frequency,
            startDate: startDate,
            anchorDate: anchorDate,
            active: active,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IncomeSourcesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IncomeSourcesTable,
    IncomeSource,
    $$IncomeSourcesTableFilterComposer,
    $$IncomeSourcesTableOrderingComposer,
    $$IncomeSourcesTableAnnotationComposer,
    $$IncomeSourcesTableCreateCompanionBuilder,
    $$IncomeSourcesTableUpdateCompanionBuilder,
    (
      IncomeSource,
      BaseReferences<_$AppDatabase, $IncomeSourcesTable, IncomeSource>
    ),
    IncomeSource,
    PrefetchHooks Function()>;
typedef $$IncomeInstancesTableCreateCompanionBuilder = IncomeInstancesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<int?> sourceId,
  Value<String?> sourceRemoteId,
  required String titleSnapshot,
  required int amountCents,
  required String date,
  Value<String> status,
  Value<DateTime?> receivedAt,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});
typedef $$IncomeInstancesTableUpdateCompanionBuilder = IncomeInstancesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<int?> sourceId,
  Value<String?> sourceRemoteId,
  Value<String> titleSnapshot,
  Value<int> amountCents,
  Value<String> date,
  Value<String> status,
  Value<DateTime?> receivedAt,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});

class $$IncomeInstancesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomeInstancesTable> {
  $$IncomeInstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceRemoteId => $composableBuilder(
      column: $table.sourceRemoteId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleSnapshot => $composableBuilder(
      column: $table.titleSnapshot, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
      column: $table.receivedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnFilters(column));
}

class $$IncomeInstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomeInstancesTable> {
  $$IncomeInstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceRemoteId => $composableBuilder(
      column: $table.sourceRemoteId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleSnapshot => $composableBuilder(
      column: $table.titleSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
      column: $table.receivedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$IncomeInstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomeInstancesTable> {
  $$IncomeInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<int> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get sourceRemoteId => $composableBuilder(
      column: $table.sourceRemoteId, builder: (column) => column);

  GeneratedColumn<String> get titleSnapshot => $composableBuilder(
      column: $table.titleSnapshot, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
      column: $table.receivedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer, builder: (column) => column);

  GeneratedColumn<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt, builder: (column) => column);
}

class $$IncomeInstancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IncomeInstancesTable,
    IncomeInstance,
    $$IncomeInstancesTableFilterComposer,
    $$IncomeInstancesTableOrderingComposer,
    $$IncomeInstancesTableAnnotationComposer,
    $$IncomeInstancesTableCreateCompanionBuilder,
    $$IncomeInstancesTableUpdateCompanionBuilder,
    (
      IncomeInstance,
      BaseReferences<_$AppDatabase, $IncomeInstancesTable, IncomeInstance>
    ),
    IncomeInstance,
    PrefetchHooks Function()> {
  $$IncomeInstancesTableTableManager(
      _$AppDatabase db, $IncomeInstancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeInstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<int?> sourceId = const Value.absent(),
            Value<String?> sourceRemoteId = const Value.absent(),
            Value<String> titleSnapshot = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> receivedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              IncomeInstancesCompanion(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            sourceId: sourceId,
            sourceRemoteId: sourceRemoteId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            date: date,
            status: status,
            receivedAt: receivedAt,
            notes: notes,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<int?> sourceId = const Value.absent(),
            Value<String?> sourceRemoteId = const Value.absent(),
            required String titleSnapshot,
            required int amountCents,
            required String date,
            Value<String> status = const Value.absent(),
            Value<DateTime?> receivedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              IncomeInstancesCompanion.insert(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            sourceId: sourceId,
            sourceRemoteId: sourceRemoteId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            date: date,
            status: status,
            receivedAt: receivedAt,
            notes: notes,
            createdAt: createdAt,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IncomeInstancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IncomeInstancesTable,
    IncomeInstance,
    $$IncomeInstancesTableFilterComposer,
    $$IncomeInstancesTableOrderingComposer,
    $$IncomeInstancesTableAnnotationComposer,
    $$IncomeInstancesTableCreateCompanionBuilder,
    $$IncomeInstancesTableUpdateCompanionBuilder,
    (
      IncomeInstance,
      BaseReferences<_$AppDatabase, $IncomeInstancesTable, IncomeInstance>
    ),
    IncomeInstance,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  required String name,
  Value<String?> color,
  Value<String?> icon,
  Value<int> sortOrder,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> profileId,
  Value<String?> remoteId,
  Value<String?> householdId,
  Value<String> name,
  Value<String?> color,
  Value<String?> icon,
  Value<int> sortOrder,
  Value<int?> updatedAtServer,
  Value<int?> deletedAtServer,
  Value<String?> deviceId,
  Value<int?> clientUpdatedAt,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get householdId => $composableBuilder(
      column: $table.householdId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get updatedAtServer => $composableBuilder(
      column: $table.updatedAtServer, builder: (column) => column);

  GeneratedColumn<int> get deletedAtServer => $composableBuilder(
      column: $table.deletedAtServer, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get clientUpdatedAt => $composableBuilder(
      column: $table.clientUpdatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            name: name,
            color: color,
            icon: icon,
            sortOrder: sortOrder,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<String?> householdId = const Value.absent(),
            required String name,
            Value<String?> color = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int?> updatedAtServer = const Value.absent(),
            Value<int?> deletedAtServer = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
            Value<int?> clientUpdatedAt = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            profileId: profileId,
            remoteId: remoteId,
            householdId: householdId,
            name: name,
            color: color,
            icon: icon,
            sortOrder: sortOrder,
            updatedAtServer: updatedAtServer,
            deletedAtServer: deletedAtServer,
            deviceId: deviceId,
            clientUpdatedAt: clientUpdatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()>;
typedef $$SyncSettingsTableCreateCompanionBuilder = SyncSettingsCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<bool> useRemote,
  Value<String?> baseUrl,
  Value<String?> apiKey,
  Value<String> mode,
  Value<DateTime> updatedAt,
  Value<int> lastSyncServerMs,
  Value<String?> deviceId,
});
typedef $$SyncSettingsTableUpdateCompanionBuilder = SyncSettingsCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<bool> useRemote,
  Value<String?> baseUrl,
  Value<String?> apiKey,
  Value<String> mode,
  Value<DateTime> updatedAt,
  Value<int> lastSyncServerMs,
  Value<String?> deviceId,
});

class $$SyncSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncSettingsTable> {
  $$SyncSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get useRemote => $composableBuilder(
      column: $table.useRemote, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get baseUrl => $composableBuilder(
      column: $table.baseUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apiKey => $composableBuilder(
      column: $table.apiKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncServerMs => $composableBuilder(
      column: $table.lastSyncServerMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));
}

class $$SyncSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncSettingsTable> {
  $$SyncSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get useRemote => $composableBuilder(
      column: $table.useRemote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get baseUrl => $composableBuilder(
      column: $table.baseUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apiKey => $composableBuilder(
      column: $table.apiKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncServerMs => $composableBuilder(
      column: $table.lastSyncServerMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));
}

class $$SyncSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncSettingsTable> {
  $$SyncSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<bool> get useRemote =>
      $composableBuilder(column: $table.useRemote, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get lastSyncServerMs => $composableBuilder(
      column: $table.lastSyncServerMs, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);
}

class $$SyncSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncSettingsTable,
    SyncSetting,
    $$SyncSettingsTableFilterComposer,
    $$SyncSettingsTableOrderingComposer,
    $$SyncSettingsTableAnnotationComposer,
    $$SyncSettingsTableCreateCompanionBuilder,
    $$SyncSettingsTableUpdateCompanionBuilder,
    (
      SyncSetting,
      BaseReferences<_$AppDatabase, $SyncSettingsTable, SyncSetting>
    ),
    SyncSetting,
    PrefetchHooks Function()> {
  $$SyncSettingsTableTableManager(_$AppDatabase db, $SyncSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<bool> useRemote = const Value.absent(),
            Value<String?> baseUrl = const Value.absent(),
            Value<String?> apiKey = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> lastSyncServerMs = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
          }) =>
              SyncSettingsCompanion(
            id: id,
            profileId: profileId,
            useRemote: useRemote,
            baseUrl: baseUrl,
            apiKey: apiKey,
            mode: mode,
            updatedAt: updatedAt,
            lastSyncServerMs: lastSyncServerMs,
            deviceId: deviceId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<bool> useRemote = const Value.absent(),
            Value<String?> baseUrl = const Value.absent(),
            Value<String?> apiKey = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> lastSyncServerMs = const Value.absent(),
            Value<String?> deviceId = const Value.absent(),
          }) =>
              SyncSettingsCompanion.insert(
            id: id,
            profileId: profileId,
            useRemote: useRemote,
            baseUrl: baseUrl,
            apiKey: apiKey,
            mode: mode,
            updatedAt: updatedAt,
            lastSyncServerMs: lastSyncServerMs,
            deviceId: deviceId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncSettingsTable,
    SyncSetting,
    $$SyncSettingsTableFilterComposer,
    $$SyncSettingsTableOrderingComposer,
    $$SyncSettingsTableAnnotationComposer,
    $$SyncSettingsTableCreateCompanionBuilder,
    $$SyncSettingsTableUpdateCompanionBuilder,
    (
      SyncSetting,
      BaseReferences<_$AppDatabase, $SyncSettingsTable, SyncSetting>
    ),
    SyncSetting,
    PrefetchHooks Function()>;
typedef $$OutboxEntriesTableCreateCompanionBuilder = OutboxEntriesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  required String entityType,
  required String entityId,
  required String op,
  Value<String?> payloadJson,
  Value<DateTime> queuedAt,
});
typedef $$OutboxEntriesTableUpdateCompanionBuilder = OutboxEntriesCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> op,
  Value<String?> payloadJson,
  Value<DateTime> queuedAt,
});

class $$OutboxEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get op => $composableBuilder(
      column: $table.op, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
      column: $table.queuedAt, builder: (column) => ColumnFilters(column));
}

class $$OutboxEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get op => $composableBuilder(
      column: $table.op, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
      column: $table.queuedAt, builder: (column) => ColumnOrderings(column));
}

class $$OutboxEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get op =>
      $composableBuilder(column: $table.op, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);
}

class $$OutboxEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OutboxEntriesTable,
    OutboxEntry,
    $$OutboxEntriesTableFilterComposer,
    $$OutboxEntriesTableOrderingComposer,
    $$OutboxEntriesTableAnnotationComposer,
    $$OutboxEntriesTableCreateCompanionBuilder,
    $$OutboxEntriesTableUpdateCompanionBuilder,
    (
      OutboxEntry,
      BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntry>
    ),
    OutboxEntry,
    PrefetchHooks Function()> {
  $$OutboxEntriesTableTableManager(_$AppDatabase db, $OutboxEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> op = const Value.absent(),
            Value<String?> payloadJson = const Value.absent(),
            Value<DateTime> queuedAt = const Value.absent(),
          }) =>
              OutboxEntriesCompanion(
            id: id,
            profileId: profileId,
            entityType: entityType,
            entityId: entityId,
            op: op,
            payloadJson: payloadJson,
            queuedAt: queuedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            required String entityType,
            required String entityId,
            required String op,
            Value<String?> payloadJson = const Value.absent(),
            Value<DateTime> queuedAt = const Value.absent(),
          }) =>
              OutboxEntriesCompanion.insert(
            id: id,
            profileId: profileId,
            entityType: entityType,
            entityId: entityId,
            op: op,
            payloadJson: payloadJson,
            queuedAt: queuedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OutboxEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OutboxEntriesTable,
    OutboxEntry,
    $$OutboxEntriesTableFilterComposer,
    $$OutboxEntriesTableOrderingComposer,
    $$OutboxEntriesTableAnnotationComposer,
    $$OutboxEntriesTableCreateCompanionBuilder,
    $$OutboxEntriesTableUpdateCompanionBuilder,
    (
      OutboxEntry,
      BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntry>
    ),
    OutboxEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BillTemplatesTableTableManager get billTemplates =>
      $$BillTemplatesTableTableManager(_db, _db.billTemplates);
  $$BillInstancesTableTableManager get billInstances =>
      $$BillInstancesTableTableManager(_db, _db.billInstances);
  $$IncomeSourcesTableTableManager get incomeSources =>
      $$IncomeSourcesTableTableManager(_db, _db.incomeSources);
  $$IncomeInstancesTableTableManager get incomeInstances =>
      $$IncomeInstancesTableTableManager(_db, _db.incomeInstances);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$SyncSettingsTableTableManager get syncSettings =>
      $$SyncSettingsTableTableManager(_db, _db.syncSettings);
  $$OutboxEntriesTableTableManager get outboxEntries =>
      $$OutboxEntriesTableTableManager(_db, _db.outboxEntries);
}
