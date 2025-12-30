import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'secure_key.dart';

part 'app_database.g.dart';

class BillTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  IntColumn get defaultAmountCents => integer()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  /// JSON string, e.g. {"type":"monthly","day":1}
  TextColumn get recurrenceRule => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class BillInstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().nullable()(); // null for one-time
  TextColumn get titleSnapshot => text()();
  IntColumn get amountCents => integer()();
  TextColumn get dueDate => text()(); // YYYY-MM-DD
  TextColumn get status => text().withDefault(const Constant('scheduled'))(); // scheduled|paid|skipped|partial
  IntColumn get paidAmountCents => integer().nullable()();
  DateTimeColumn get paidAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get category => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class IncomeSources extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get amountCents => integer()();
  TextColumn get frequency => text()(); // monthly|weekly|biweekly|one_time|yearly
  TextColumn get anchorDate => text().nullable()(); // YYYY-MM-DD
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class IncomeInstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sourceId => integer().nullable()(); // null for one-time
  TextColumn get titleSnapshot => text()();
  IntColumn get amountCents => integer()();
  TextColumn get date => text()(); // YYYY-MM-DD
  TextColumn get status => text().withDefault(const Constant('expected'))(); // expected|received|skipped
  DateTimeColumn get receivedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get color => text().nullable()(); // Hex color code
  TextColumn get icon => text().nullable()(); // Icon name
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [BillTemplates, BillInstances, IncomeSources, IncomeInstances, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static Future<AppDatabase> open() async {
    final key = await SecureDbKey.getOrCreate();

    final executor = driftDatabase(
      name: 'budget_calendar.db',
      native: const DriftNativeOptions(),
    );

    final db = AppDatabase(executor);
    
    // Apply encryption key via raw query
    await db.customStatement("PRAGMA key = '$key';");
    await db.customStatement("PRAGMA foreign_keys = ON;");
    
    return db;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      // Insert default categories
      await into(categories).insert(CategoriesCompanion.insert(name: 'Housing', color: const Value('#4CAF50'), sortOrder: const Value(1)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Utilities', color: const Value('#2196F3'), sortOrder: const Value(2)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Transportation', color: const Value('#FF9800'), sortOrder: const Value(3)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Insurance', color: const Value('#9C27B0'), sortOrder: const Value(4)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Subscriptions', color: const Value('#E91E63'), sortOrder: const Value(5)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Food', color: const Value('#795548'), sortOrder: const Value(6)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Healthcare', color: const Value('#00BCD4'), sortOrder: const Value(7)));
      await into(categories).insert(CategoriesCompanion.insert(name: 'Other', color: const Value('#607D8B'), sortOrder: const Value(99)));
    },
  );

  // ------------ Category operations ------------

  Future<List<Category>> getAllCategories() {
    return (select(categories)..orderBy([(c) => OrderingTerm.asc(c.sortOrder)])).get();
  }

  Stream<List<Category>> watchAllCategories() {
    return (select(categories)..orderBy([(c) => OrderingTerm.asc(c.sortOrder)])).watch();
  }

  Future<int> addCategory({required String name, String? color}) {
    return into(categories).insert(CategoriesCompanion.insert(
      name: name,
      color: Value(color),
    ));
  }

  // ------------ Bill Template operations ------------

  Future<List<BillTemplate>> getAllBillTemplates() {
    return (select(billTemplates)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Stream<List<BillTemplate>> watchAllBillTemplates() {
    return (select(billTemplates)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  Future<List<BillTemplate>> getActiveBillTemplates() {
    return (select(billTemplates)
      ..where((t) => t.active.equals(true) & t.recurrenceRule.isNotNull())
      ..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Future<int> upsertBillTemplate({
    int? id,
    required String name,
    String? category,
    required int defaultAmountCents,
    String? recurrenceRuleJson,
    bool active = true,
  }) async {
    final companion = BillTemplatesCompanion(
      id: id == null ? const Value.absent() : Value(id),
      name: Value(name),
      category: Value(category),
      defaultAmountCents: Value(defaultAmountCents),
      recurrenceRule: Value(recurrenceRuleJson),
      active: Value(active),
    );

    if (id == null) {
      return into(billTemplates).insert(companion);
    }
    await (update(billTemplates)..where((t) => t.id.equals(id))).write(companion);
    return id;
  }

  Future<void> deleteBillTemplate(int id) async {
    await (delete(billTemplates)..where((t) => t.id.equals(id))).go();
  }

  Future<void> toggleBillTemplateActive(int id, bool active) async {
    await (update(billTemplates)..where((t) => t.id.equals(id))).write(
      BillTemplatesCompanion(active: Value(active)),
    );
  }

  // ------------ Bill Instance operations ------------

  Future<List<BillInstance>> getBillInstancesForDate(String dateStr) {
    return (select(billInstances)
      ..where((i) => i.dueDate.equals(dateStr) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.id)])).get();
  }

  Stream<List<BillInstance>> watchBillInstancesForDate(String dateStr) {
    return (select(billInstances)
      ..where((i) => i.dueDate.equals(dateStr) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.id)])).watch();
  }

  Future<List<BillInstance>> getBillInstancesForMonth(String startDate, String endDate) {
    return (select(billInstances)
      ..where((i) => i.dueDate.isBetweenValues(startDate, endDate) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.dueDate)])).get();
  }

  Stream<List<BillInstance>> watchBillInstancesForMonth(String startDate, String endDate) {
    return (select(billInstances)
      ..where((i) => i.dueDate.isBetweenValues(startDate, endDate))
      ..orderBy([(i) => OrderingTerm.asc(i.dueDate)])).watch();
  }

  Future<BillInstance?> getBillInstanceByTemplateAndDate(int templateId, String dateStr) {
    return (select(billInstances)
      ..where((i) => i.templateId.equals(templateId) & i.dueDate.equals(dateStr)))
        .getSingleOrNull();
  }

  Future<int> addOneTimeBillInstance({
    required String title,
    required int amountCents,
    required String dueDate,
    String? notes,
    String? category,
  }) {
    return into(billInstances).insert(
      BillInstancesCompanion(
        templateId: const Value(null),
        titleSnapshot: Value(title),
        amountCents: Value(amountCents),
        dueDate: Value(dueDate),
        notes: Value(notes),
        category: Value(category),
      ),
    );
  }

  Future<int> addRecurringBillInstance({
    required int templateId,
    required String title,
    required int amountCents,
    required String dueDate,
    String? category,
  }) {
    return into(billInstances).insert(
      BillInstancesCompanion(
        templateId: Value(templateId),
        titleSnapshot: Value(title),
        amountCents: Value(amountCents),
        dueDate: Value(dueDate),
        category: Value(category),
      ),
    );
  }

  Future<void> markBillPaid({
    required int instanceId,
    required int paidAmountCents,
  }) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      BillInstancesCompanion(
        status: const Value('paid'),
        paidAmountCents: Value(paidAmountCents),
        paidAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markBillPartialPaid({
    required int instanceId,
    required int paidAmountCents,
  }) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      BillInstancesCompanion(
        status: const Value('partial'),
        paidAmountCents: Value(paidAmountCents),
        paidAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markBillUnpaid({required int instanceId}) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      const BillInstancesCompanion(
        status: Value('scheduled'),
        paidAmountCents: Value(null),
        paidAt: Value(null),
      ),
    );
  }

  Future<void> skipBillInstance({required int instanceId}) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      const BillInstancesCompanion(status: Value('skipped')),
    );
  }

  Future<void> unskipBillInstance({required int instanceId}) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      const BillInstancesCompanion(status: Value('scheduled')),
    );
  }

  Future<void> updateBillInstanceAmount({
    required int instanceId,
    required int amountCents,
  }) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      BillInstancesCompanion(amountCents: Value(amountCents)),
    );
  }

  Future<void> updateBillInstanceNotes({
    required int instanceId,
    String? notes,
  }) async {
    await (update(billInstances)..where((i) => i.id.equals(instanceId))).write(
      BillInstancesCompanion(notes: Value(notes)),
    );
  }

  Future<void> deleteBillInstance(int id) async {
    await (delete(billInstances)..where((i) => i.id.equals(id))).go();
  }

  // ------------ Income Source operations ------------

  Future<List<IncomeSource>> getAllIncomeSources() {
    return (select(incomeSources)..orderBy([(s) => OrderingTerm.asc(s.name)])).get();
  }

  Stream<List<IncomeSource>> watchAllIncomeSources() {
    return (select(incomeSources)..orderBy([(s) => OrderingTerm.asc(s.name)])).watch();
  }

  Future<List<IncomeSource>> getActiveIncomeSources() {
    return (select(incomeSources)
      ..where((s) => s.active.equals(true))
      ..orderBy([(s) => OrderingTerm.asc(s.name)])).get();
  }

  Future<int> upsertIncomeSource({
    int? id,
    required String name,
    required int amountCents,
    required String frequency,
    String? anchorDate,
    bool active = true,
  }) async {
    final companion = IncomeSourcesCompanion(
      id: id == null ? const Value.absent() : Value(id),
      name: Value(name),
      amountCents: Value(amountCents),
      frequency: Value(frequency),
      anchorDate: Value(anchorDate),
      active: Value(active),
    );

    if (id == null) {
      return into(incomeSources).insert(companion);
    }
    await (update(incomeSources)..where((s) => s.id.equals(id))).write(companion);
    return id;
  }

  Future<void> deleteIncomeSource(int id) async {
    await (delete(incomeSources)..where((s) => s.id.equals(id))).go();
  }

  // ------------ Income Instance operations ------------

  Future<List<IncomeInstance>> getIncomeInstancesForMonth(String startDate, String endDate) {
    return (select(incomeInstances)
      ..where((i) => i.date.isBetweenValues(startDate, endDate) & i.status.isNotIn(['skipped']))
      ..orderBy([(i) => OrderingTerm.asc(i.date)])).get();
  }

  Stream<List<IncomeInstance>> watchIncomeInstancesForMonth(String startDate, String endDate) {
    return (select(incomeInstances)
      ..where((i) => i.date.isBetweenValues(startDate, endDate))
      ..orderBy([(i) => OrderingTerm.asc(i.date)])).watch();
  }

  Stream<List<IncomeInstance>> watchAllIncomeInstances() {
    return (select(incomeInstances)..orderBy([(i) => OrderingTerm.desc(i.date)])).watch();
  }

  Future<IncomeInstance?> getIncomeInstanceBySourceAndDate(int sourceId, String dateStr) {
    return (select(incomeInstances)
      ..where((i) => i.sourceId.equals(sourceId) & i.date.equals(dateStr)))
        .getSingleOrNull();
  }

  Future<int> addOneTimeIncomeInstance({
    required String title,
    required int amountCents,
    required String date,
    String? notes,
  }) {
    return into(incomeInstances).insert(
      IncomeInstancesCompanion(
        sourceId: const Value(null),
        titleSnapshot: Value(title),
        amountCents: Value(amountCents),
        date: Value(date),
        notes: Value(notes),
      ),
    );
  }

  Future<int> addRecurringIncomeInstance({
    required int sourceId,
    required String title,
    required int amountCents,
    required String date,
  }) {
    return into(incomeInstances).insert(
      IncomeInstancesCompanion(
        sourceId: Value(sourceId),
        titleSnapshot: Value(title),
        amountCents: Value(amountCents),
        date: Value(date),
      ),
    );
  }

  Future<void> markIncomeReceived({required int instanceId}) async {
    await (update(incomeInstances)..where((i) => i.id.equals(instanceId))).write(
      IncomeInstancesCompanion(
        status: const Value('received'),
        receivedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markIncomeExpected({required int instanceId}) async {
    await (update(incomeInstances)..where((i) => i.id.equals(instanceId))).write(
      const IncomeInstancesCompanion(
        status: Value('expected'),
        receivedAt: Value(null),
      ),
    );
  }

  Future<void> skipIncomeInstance({required int instanceId}) async {
    await (update(incomeInstances)..where((i) => i.id.equals(instanceId))).write(
      const IncomeInstancesCompanion(status: Value('skipped')),
    );
  }

  Future<void> updateIncomeInstanceAmount({
    required int instanceId,
    required int amountCents,
  }) async {
    await (update(incomeInstances)..where((i) => i.id.equals(instanceId))).write(
      IncomeInstancesCompanion(amountCents: Value(amountCents)),
    );
  }

  Future<void> deleteIncomeInstance(int id) async {
    await (delete(incomeInstances)..where((i) => i.id.equals(id))).go();
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
      ..where((i) => i.dueDate.isBetweenValues(startDate, endDate) & i.status.equals('scheduled'))
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
