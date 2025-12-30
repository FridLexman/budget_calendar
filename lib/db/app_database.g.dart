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
  static const VerificationMeta _defaultAmountCentsMeta =
      const VerificationMeta('defaultAmountCents');
  @override
  late final GeneratedColumn<int> defaultAmountCents = GeneratedColumn<int>(
      'default_amount_cents', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        defaultAmountCents,
        active,
        recurrenceRule,
        createdAt
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
    if (data.containsKey('default_amount_cents')) {
      context.handle(
          _defaultAmountCentsMeta,
          defaultAmountCents.isAcceptableOrUnknown(
              data['default_amount_cents']!, _defaultAmountCentsMeta));
    } else if (isInserting) {
      context.missing(_defaultAmountCentsMeta);
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
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      defaultAmountCents: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}default_amount_cents'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      recurrenceRule: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurrence_rule']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BillTemplatesTable createAlias(String alias) {
    return $BillTemplatesTable(attachedDatabase, alias);
  }
}

class BillTemplate extends DataClass implements Insertable<BillTemplate> {
  final int id;
  final String name;
  final String? category;
  final int defaultAmountCents;
  final bool active;

  /// JSON string, e.g. {"type":"monthly","day":1}
  final String? recurrenceRule;
  final DateTime createdAt;
  const BillTemplate(
      {required this.id,
      required this.name,
      this.category,
      required this.defaultAmountCents,
      required this.active,
      this.recurrenceRule,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['default_amount_cents'] = Variable<int>(defaultAmountCents);
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillTemplatesCompanion toCompanion(bool nullToAbsent) {
    return BillTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      defaultAmountCents: Value(defaultAmountCents),
      active: Value(active),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      createdAt: Value(createdAt),
    );
  }

  factory BillTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      defaultAmountCents: serializer.fromJson<int>(json['defaultAmountCents']),
      active: serializer.fromJson<bool>(json['active']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrenceRule']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'defaultAmountCents': serializer.toJson<int>(defaultAmountCents),
      'active': serializer.toJson<bool>(active),
      'recurrenceRule': serializer.toJson<String?>(recurrenceRule),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BillTemplate copyWith(
          {int? id,
          String? name,
          Value<String?> category = const Value.absent(),
          int? defaultAmountCents,
          bool? active,
          Value<String?> recurrenceRule = const Value.absent(),
          DateTime? createdAt}) =>
      BillTemplate(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category.present ? category.value : this.category,
        defaultAmountCents: defaultAmountCents ?? this.defaultAmountCents,
        active: active ?? this.active,
        recurrenceRule:
            recurrenceRule.present ? recurrenceRule.value : this.recurrenceRule,
        createdAt: createdAt ?? this.createdAt,
      );
  BillTemplate copyWithCompanion(BillTemplatesCompanion data) {
    return BillTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      defaultAmountCents: data.defaultAmountCents.present
          ? data.defaultAmountCents.value
          : this.defaultAmountCents,
      active: data.active.present ? data.active.value : this.active,
      recurrenceRule: data.recurrenceRule.present
          ? data.recurrenceRule.value
          : this.recurrenceRule,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('defaultAmountCents: $defaultAmountCents, ')
          ..write('active: $active, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, defaultAmountCents,
      active, recurrenceRule, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.defaultAmountCents == this.defaultAmountCents &&
          other.active == this.active &&
          other.recurrenceRule == this.recurrenceRule &&
          other.createdAt == this.createdAt);
}

class BillTemplatesCompanion extends UpdateCompanion<BillTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<int> defaultAmountCents;
  final Value<bool> active;
  final Value<String?> recurrenceRule;
  final Value<DateTime> createdAt;
  const BillTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultAmountCents = const Value.absent(),
    this.active = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BillTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    required int defaultAmountCents,
    this.active = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        defaultAmountCents = Value(defaultAmountCents);
  static Insertable<BillTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? defaultAmountCents,
    Expression<bool>? active,
    Expression<String>? recurrenceRule,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (defaultAmountCents != null)
        'default_amount_cents': defaultAmountCents,
      if (active != null) 'active': active,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BillTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? category,
      Value<int>? defaultAmountCents,
      Value<bool>? active,
      Value<String?>? recurrenceRule,
      Value<DateTime>? createdAt}) {
    return BillTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      defaultAmountCents: defaultAmountCents ?? this.defaultAmountCents,
      active: active ?? this.active,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (defaultAmountCents.present) {
      map['default_amount_cents'] = Variable<int>(defaultAmountCents.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('defaultAmountCents: $defaultAmountCents, ')
          ..write('active: $active, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('createdAt: $createdAt')
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
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        templateId,
        titleSnapshot,
        amountCents,
        dueDate,
        status,
        paidAmountCents,
        paidAt,
        notes,
        category,
        createdAt
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
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
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
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id']),
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BillInstancesTable createAlias(String alias) {
    return $BillInstancesTable(attachedDatabase, alias);
  }
}

class BillInstance extends DataClass implements Insertable<BillInstance> {
  final int id;
  final int? templateId;
  final String titleSnapshot;
  final int amountCents;
  final String dueDate;
  final String status;
  final int? paidAmountCents;
  final DateTime? paidAt;
  final String? notes;
  final String? category;
  final DateTime createdAt;
  const BillInstance(
      {required this.id,
      this.templateId,
      required this.titleSnapshot,
      required this.amountCents,
      required this.dueDate,
      required this.status,
      this.paidAmountCents,
      this.paidAt,
      this.notes,
      this.category,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<int>(templateId);
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
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillInstancesCompanion toCompanion(bool nullToAbsent) {
    return BillInstancesCompanion(
      id: Value(id),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
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
      createdAt: Value(createdAt),
    );
  }

  factory BillInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillInstance(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int?>(json['templateId']),
      titleSnapshot: serializer.fromJson<String>(json['titleSnapshot']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      status: serializer.fromJson<String>(json['status']),
      paidAmountCents: serializer.fromJson<int?>(json['paidAmountCents']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      category: serializer.fromJson<String?>(json['category']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int?>(templateId),
      'titleSnapshot': serializer.toJson<String>(titleSnapshot),
      'amountCents': serializer.toJson<int>(amountCents),
      'dueDate': serializer.toJson<String>(dueDate),
      'status': serializer.toJson<String>(status),
      'paidAmountCents': serializer.toJson<int?>(paidAmountCents),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'notes': serializer.toJson<String?>(notes),
      'category': serializer.toJson<String?>(category),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BillInstance copyWith(
          {int? id,
          Value<int?> templateId = const Value.absent(),
          String? titleSnapshot,
          int? amountCents,
          String? dueDate,
          String? status,
          Value<int?> paidAmountCents = const Value.absent(),
          Value<DateTime?> paidAt = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> category = const Value.absent(),
          DateTime? createdAt}) =>
      BillInstance(
        id: id ?? this.id,
        templateId: templateId.present ? templateId.value : this.templateId,
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
        createdAt: createdAt ?? this.createdAt,
      );
  BillInstance copyWithCompanion(BillInstancesCompanion data) {
    return BillInstance(
      id: data.id.present ? data.id.value : this.id,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
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
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillInstance(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidAmountCents: $paidAmountCents, ')
          ..write('paidAt: $paidAt, ')
          ..write('notes: $notes, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, templateId, titleSnapshot, amountCents,
      dueDate, status, paidAmountCents, paidAt, notes, category, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillInstance &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.titleSnapshot == this.titleSnapshot &&
          other.amountCents == this.amountCents &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.paidAmountCents == this.paidAmountCents &&
          other.paidAt == this.paidAt &&
          other.notes == this.notes &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class BillInstancesCompanion extends UpdateCompanion<BillInstance> {
  final Value<int> id;
  final Value<int?> templateId;
  final Value<String> titleSnapshot;
  final Value<int> amountCents;
  final Value<String> dueDate;
  final Value<String> status;
  final Value<int?> paidAmountCents;
  final Value<DateTime?> paidAt;
  final Value<String?> notes;
  final Value<String?> category;
  final Value<DateTime> createdAt;
  const BillInstancesCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.titleSnapshot = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.paidAmountCents = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BillInstancesCompanion.insert({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    required String titleSnapshot,
    required int amountCents,
    required String dueDate,
    this.status = const Value.absent(),
    this.paidAmountCents = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : titleSnapshot = Value(titleSnapshot),
        amountCents = Value(amountCents),
        dueDate = Value(dueDate);
  static Insertable<BillInstance> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? titleSnapshot,
    Expression<int>? amountCents,
    Expression<String>? dueDate,
    Expression<String>? status,
    Expression<int>? paidAmountCents,
    Expression<DateTime>? paidAt,
    Expression<String>? notes,
    Expression<String>? category,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (titleSnapshot != null) 'title_snapshot': titleSnapshot,
      if (amountCents != null) 'amount_cents': amountCents,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (paidAmountCents != null) 'paid_amount_cents': paidAmountCents,
      if (paidAt != null) 'paid_at': paidAt,
      if (notes != null) 'notes': notes,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BillInstancesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? templateId,
      Value<String>? titleSnapshot,
      Value<int>? amountCents,
      Value<String>? dueDate,
      Value<String>? status,
      Value<int?>? paidAmountCents,
      Value<DateTime?>? paidAt,
      Value<String?>? notes,
      Value<String?>? category,
      Value<DateTime>? createdAt}) {
    return BillInstancesCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      titleSnapshot: titleSnapshot ?? this.titleSnapshot,
      amountCents: amountCents ?? this.amountCents,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidAmountCents: paidAmountCents ?? this.paidAmountCents,
      paidAt: paidAt ?? this.paidAt,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
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
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillInstancesCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidAmountCents: $paidAmountCents, ')
          ..write('paidAt: $paidAt, ')
          ..write('notes: $notes, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, amountCents, frequency, anchorDate, active, createdAt];
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
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amountCents: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_cents'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      anchorDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}anchor_date']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $IncomeSourcesTable createAlias(String alias) {
    return $IncomeSourcesTable(attachedDatabase, alias);
  }
}

class IncomeSource extends DataClass implements Insertable<IncomeSource> {
  final int id;
  final String name;
  final int amountCents;
  final String frequency;
  final String? anchorDate;
  final bool active;
  final DateTime createdAt;
  const IncomeSource(
      {required this.id,
      required this.name,
      required this.amountCents,
      required this.frequency,
      this.anchorDate,
      required this.active,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['amount_cents'] = Variable<int>(amountCents);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || anchorDate != null) {
      map['anchor_date'] = Variable<String>(anchorDate);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IncomeSourcesCompanion toCompanion(bool nullToAbsent) {
    return IncomeSourcesCompanion(
      id: Value(id),
      name: Value(name),
      amountCents: Value(amountCents),
      frequency: Value(frequency),
      anchorDate: anchorDate == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorDate),
      active: Value(active),
      createdAt: Value(createdAt),
    );
  }

  factory IncomeSource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeSource(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      frequency: serializer.fromJson<String>(json['frequency']),
      anchorDate: serializer.fromJson<String?>(json['anchorDate']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'amountCents': serializer.toJson<int>(amountCents),
      'frequency': serializer.toJson<String>(frequency),
      'anchorDate': serializer.toJson<String?>(anchorDate),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  IncomeSource copyWith(
          {int? id,
          String? name,
          int? amountCents,
          String? frequency,
          Value<String?> anchorDate = const Value.absent(),
          bool? active,
          DateTime? createdAt}) =>
      IncomeSource(
        id: id ?? this.id,
        name: name ?? this.name,
        amountCents: amountCents ?? this.amountCents,
        frequency: frequency ?? this.frequency,
        anchorDate: anchorDate.present ? anchorDate.value : this.anchorDate,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
      );
  IncomeSource copyWithCompanion(IncomeSourcesCompanion data) {
    return IncomeSource(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amountCents:
          data.amountCents.present ? data.amountCents.value : this.amountCents,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      anchorDate:
          data.anchorDate.present ? data.anchorDate.value : this.anchorDate,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSource(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amountCents: $amountCents, ')
          ..write('frequency: $frequency, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, amountCents, frequency, anchorDate, active, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeSource &&
          other.id == this.id &&
          other.name == this.name &&
          other.amountCents == this.amountCents &&
          other.frequency == this.frequency &&
          other.anchorDate == this.anchorDate &&
          other.active == this.active &&
          other.createdAt == this.createdAt);
}

class IncomeSourcesCompanion extends UpdateCompanion<IncomeSource> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> amountCents;
  final Value<String> frequency;
  final Value<String?> anchorDate;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  const IncomeSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.frequency = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IncomeSourcesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int amountCents,
    required String frequency,
    this.anchorDate = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        amountCents = Value(amountCents),
        frequency = Value(frequency);
  static Insertable<IncomeSource> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? amountCents,
    Expression<String>? frequency,
    Expression<String>? anchorDate,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amountCents != null) 'amount_cents': amountCents,
      if (frequency != null) 'frequency': frequency,
      if (anchorDate != null) 'anchor_date': anchorDate,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IncomeSourcesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? amountCents,
      Value<String>? frequency,
      Value<String?>? anchorDate,
      Value<bool>? active,
      Value<DateTime>? createdAt}) {
    return IncomeSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amountCents: amountCents ?? this.amountCents,
      frequency: frequency ?? this.frequency,
      anchorDate: anchorDate ?? this.anchorDate,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (anchorDate.present) {
      map['anchor_date'] = Variable<String>(anchorDate.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amountCents: $amountCents, ')
          ..write('frequency: $frequency, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
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
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
      'source_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sourceId,
        titleSnapshot,
        amountCents,
        date,
        status,
        receivedAt,
        notes,
        createdAt
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
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
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
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_id']),
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
    );
  }

  @override
  $IncomeInstancesTable createAlias(String alias) {
    return $IncomeInstancesTable(attachedDatabase, alias);
  }
}

class IncomeInstance extends DataClass implements Insertable<IncomeInstance> {
  final int id;
  final int? sourceId;
  final String titleSnapshot;
  final int amountCents;
  final String date;
  final String status;
  final DateTime? receivedAt;
  final String? notes;
  final DateTime createdAt;
  const IncomeInstance(
      {required this.id,
      this.sourceId,
      required this.titleSnapshot,
      required this.amountCents,
      required this.date,
      required this.status,
      this.receivedAt,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<int>(sourceId);
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
    return map;
  }

  IncomeInstancesCompanion toCompanion(bool nullToAbsent) {
    return IncomeInstancesCompanion(
      id: Value(id),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
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
    );
  }

  factory IncomeInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeInstance(
      id: serializer.fromJson<int>(json['id']),
      sourceId: serializer.fromJson<int?>(json['sourceId']),
      titleSnapshot: serializer.fromJson<String>(json['titleSnapshot']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      receivedAt: serializer.fromJson<DateTime?>(json['receivedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceId': serializer.toJson<int?>(sourceId),
      'titleSnapshot': serializer.toJson<String>(titleSnapshot),
      'amountCents': serializer.toJson<int>(amountCents),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'receivedAt': serializer.toJson<DateTime?>(receivedAt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  IncomeInstance copyWith(
          {int? id,
          Value<int?> sourceId = const Value.absent(),
          String? titleSnapshot,
          int? amountCents,
          String? date,
          String? status,
          Value<DateTime?> receivedAt = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      IncomeInstance(
        id: id ?? this.id,
        sourceId: sourceId.present ? sourceId.value : this.sourceId,
        titleSnapshot: titleSnapshot ?? this.titleSnapshot,
        amountCents: amountCents ?? this.amountCents,
        date: date ?? this.date,
        status: status ?? this.status,
        receivedAt: receivedAt.present ? receivedAt.value : this.receivedAt,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  IncomeInstance copyWithCompanion(IncomeInstancesCompanion data) {
    return IncomeInstance(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeInstance(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, titleSnapshot, amountCents,
      date, status, receivedAt, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeInstance &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.titleSnapshot == this.titleSnapshot &&
          other.amountCents == this.amountCents &&
          other.date == this.date &&
          other.status == this.status &&
          other.receivedAt == this.receivedAt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class IncomeInstancesCompanion extends UpdateCompanion<IncomeInstance> {
  final Value<int> id;
  final Value<int?> sourceId;
  final Value<String> titleSnapshot;
  final Value<int> amountCents;
  final Value<String> date;
  final Value<String> status;
  final Value<DateTime?> receivedAt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const IncomeInstancesCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.titleSnapshot = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IncomeInstancesCompanion.insert({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    required String titleSnapshot,
    required int amountCents,
    required String date,
    this.status = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : titleSnapshot = Value(titleSnapshot),
        amountCents = Value(amountCents),
        date = Value(date);
  static Insertable<IncomeInstance> custom({
    Expression<int>? id,
    Expression<int>? sourceId,
    Expression<String>? titleSnapshot,
    Expression<int>? amountCents,
    Expression<String>? date,
    Expression<String>? status,
    Expression<DateTime>? receivedAt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (titleSnapshot != null) 'title_snapshot': titleSnapshot,
      if (amountCents != null) 'amount_cents': amountCents,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (receivedAt != null) 'received_at': receivedAt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IncomeInstancesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? sourceId,
      Value<String>? titleSnapshot,
      Value<int>? amountCents,
      Value<String>? date,
      Value<String>? status,
      Value<DateTime?>? receivedAt,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return IncomeInstancesCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      titleSnapshot: titleSnapshot ?? this.titleSnapshot,
      amountCents: amountCents ?? this.amountCents,
      date: date ?? this.date,
      status: status ?? this.status,
      receivedAt: receivedAt ?? this.receivedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeInstancesCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('titleSnapshot: $titleSnapshot, ')
          ..write('amountCents: $amountCents, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
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
  @override
  List<GeneratedColumn> get $columns => [id, name, color, icon, sortOrder];
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
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String? color;
  final String? icon;
  final int sortOrder;
  const Category(
      {required this.id,
      required this.name,
      this.color,
      this.icon,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'icon': serializer.toJson<String?>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith(
          {int? id,
          String? name,
          Value<String?> color = const Value.absent(),
          Value<String?> icon = const Value.absent(),
          int? sortOrder}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color.present ? color.value : this.color,
        icon: icon.present ? icon.value : this.icon,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, icon, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<String?> icon;
  final Value<int> sortOrder;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? color,
      Value<String?>? icon,
      Value<int>? sortOrder}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder')
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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        billTemplates,
        billInstances,
        incomeSources,
        incomeInstances,
        categories
      ];
}

typedef $$BillTemplatesTableCreateCompanionBuilder = BillTemplatesCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String?> category,
  required int defaultAmountCents,
  Value<bool> active,
  Value<String?> recurrenceRule,
  Value<DateTime> createdAt,
});
typedef $$BillTemplatesTableUpdateCompanionBuilder = BillTemplatesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String?> category,
  Value<int> defaultAmountCents,
  Value<bool> active,
  Value<String?> recurrenceRule,
  Value<DateTime> createdAt,
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

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultAmountCents => $composableBuilder(
      column: $table.defaultAmountCents,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurrenceRule => $composableBuilder(
      column: $table.recurrenceRule,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultAmountCents => $composableBuilder(
      column: $table.defaultAmountCents,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurrenceRule => $composableBuilder(
      column: $table.recurrenceRule,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get defaultAmountCents => $composableBuilder(
      column: $table.defaultAmountCents, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get recurrenceRule => $composableBuilder(
      column: $table.recurrenceRule, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
            Value<String> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<int> defaultAmountCents = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<String?> recurrenceRule = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BillTemplatesCompanion(
            id: id,
            name: name,
            category: category,
            defaultAmountCents: defaultAmountCents,
            active: active,
            recurrenceRule: recurrenceRule,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> category = const Value.absent(),
            required int defaultAmountCents,
            Value<bool> active = const Value.absent(),
            Value<String?> recurrenceRule = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BillTemplatesCompanion.insert(
            id: id,
            name: name,
            category: category,
            defaultAmountCents: defaultAmountCents,
            active: active,
            recurrenceRule: recurrenceRule,
            createdAt: createdAt,
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
  Value<int?> templateId,
  required String titleSnapshot,
  required int amountCents,
  required String dueDate,
  Value<String> status,
  Value<int?> paidAmountCents,
  Value<DateTime?> paidAt,
  Value<String?> notes,
  Value<String?> category,
  Value<DateTime> createdAt,
});
typedef $$BillInstancesTableUpdateCompanionBuilder = BillInstancesCompanion
    Function({
  Value<int> id,
  Value<int?> templateId,
  Value<String> titleSnapshot,
  Value<int> amountCents,
  Value<String> dueDate,
  Value<String> status,
  Value<int?> paidAmountCents,
  Value<DateTime?> paidAt,
  Value<String?> notes,
  Value<String?> category,
  Value<DateTime> createdAt,
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

  ColumnFilters<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => column);

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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
            Value<int?> templateId = const Value.absent(),
            Value<String> titleSnapshot = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<String> dueDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> paidAmountCents = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BillInstancesCompanion(
            id: id,
            templateId: templateId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            dueDate: dueDate,
            status: status,
            paidAmountCents: paidAmountCents,
            paidAt: paidAt,
            notes: notes,
            category: category,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> templateId = const Value.absent(),
            required String titleSnapshot,
            required int amountCents,
            required String dueDate,
            Value<String> status = const Value.absent(),
            Value<int?> paidAmountCents = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BillInstancesCompanion.insert(
            id: id,
            templateId: templateId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            dueDate: dueDate,
            status: status,
            paidAmountCents: paidAmountCents,
            paidAt: paidAt,
            notes: notes,
            category: category,
            createdAt: createdAt,
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
  required String name,
  required int amountCents,
  required String frequency,
  Value<String?> anchorDate,
  Value<bool> active,
  Value<DateTime> createdAt,
});
typedef $$IncomeSourcesTableUpdateCompanionBuilder = IncomeSourcesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> amountCents,
  Value<String> frequency,
  Value<String?> anchorDate,
  Value<bool> active,
  Value<DateTime> createdAt,
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

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
      column: $table.amountCents, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get anchorDate => $composableBuilder(
      column: $table.anchorDate, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
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
            Value<String> name = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<String?> anchorDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IncomeSourcesCompanion(
            id: id,
            name: name,
            amountCents: amountCents,
            frequency: frequency,
            anchorDate: anchorDate,
            active: active,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int amountCents,
            required String frequency,
            Value<String?> anchorDate = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IncomeSourcesCompanion.insert(
            id: id,
            name: name,
            amountCents: amountCents,
            frequency: frequency,
            anchorDate: anchorDate,
            active: active,
            createdAt: createdAt,
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
  Value<int?> sourceId,
  required String titleSnapshot,
  required int amountCents,
  required String date,
  Value<String> status,
  Value<DateTime?> receivedAt,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$IncomeInstancesTableUpdateCompanionBuilder = IncomeInstancesCompanion
    Function({
  Value<int> id,
  Value<int?> sourceId,
  Value<String> titleSnapshot,
  Value<int> amountCents,
  Value<String> date,
  Value<String> status,
  Value<DateTime?> receivedAt,
  Value<String?> notes,
  Value<DateTime> createdAt,
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

  ColumnFilters<int> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<int> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<int> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

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
            Value<int?> sourceId = const Value.absent(),
            Value<String> titleSnapshot = const Value.absent(),
            Value<int> amountCents = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> receivedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IncomeInstancesCompanion(
            id: id,
            sourceId: sourceId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            date: date,
            status: status,
            receivedAt: receivedAt,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> sourceId = const Value.absent(),
            required String titleSnapshot,
            required int amountCents,
            required String date,
            Value<String> status = const Value.absent(),
            Value<DateTime?> receivedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IncomeInstancesCompanion.insert(
            id: id,
            sourceId: sourceId,
            titleSnapshot: titleSnapshot,
            amountCents: amountCents,
            date: date,
            status: status,
            receivedAt: receivedAt,
            notes: notes,
            createdAt: createdAt,
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
  required String name,
  Value<String?> color,
  Value<String?> icon,
  Value<int> sortOrder,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> color,
  Value<String?> icon,
  Value<int> sortOrder,
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

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
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
            Value<String> name = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            color: color,
            icon: icon,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> color = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            color: color,
            icon: icon,
            sortOrder: sortOrder,
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
}
