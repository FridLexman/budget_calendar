import '../db/app_database.dart';
import '../utils/date_utils.dart';
import 'recurrence.dart';

class MonthGenerator {
  final AppDatabase db;
  MonthGenerator(this.db);

  Future<void> ensureMonthGenerated(int year, int month) async {
    await _generateBillInstances(year, month);
    await _generateIncomeInstances(year, month);
  }

  Future<void> _generateBillInstances(int year, int month) async {
    final templates = await db.getActiveBillTemplates();

    for (final t in templates) {
      final rec = Recurrence.fromJsonString(t.recurrenceRule);
      if (rec == null) continue;
      final startLimit = t.startDate != null ? parseYmd(t.startDate!) : null;

      final dates = rec.occurrencesInMonth(year, month);
      for (final d in dates) {
        if (startLimit != null && d.isBefore(startLimit)) continue;
        final dateStr = ymd(d);

        final existing = await db.getBillInstanceByTemplateAndDate(t.id, dateStr);
        if (existing != null) continue;

        await db.addRecurringBillInstance(
          templateId: t.id,
          title: t.name,
          amountCents: t.defaultAmountCents,
          dueDate: dateStr,
          category: t.category,
        );
      }
    }
  }

  Future<void> _generateIncomeInstances(int year, int month) async {
    final sources = await db.getActiveIncomeSources();

    for (final s in sources) {
      final dates = _getIncomeDatesInMonth(s, year, month);
      for (final d in dates) {
        final dateStr = ymd(d);

        final existing = await db.getIncomeInstanceBySourceAndDate(s.id, dateStr);
        if (existing != null) continue;

        await db.addRecurringIncomeInstance(
          sourceId: s.id,
          title: s.name,
          amountCents: s.amountCents,
          date: dateStr,
        );
      }
    }
  }

  List<DateTime> _getIncomeDatesInMonth(IncomeSource source, int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0);
    List<DateTime> dates;

    switch (source.frequency) {
      case 'monthly':
        // Use anchor date's day of month, or 1st if not set
        int day = 1;
        if (source.anchorDate != null) {
          final anchor = parseYmd(source.anchorDate!);
          day = anchor.day;
        }
        final clampedDay = day.clamp(1, end.day);
        dates = [DateTime(year, month, clampedDay)];
        break;

      case 'weekly':
        // Use anchor date's weekday
        if (source.anchorDate == null) return [];
        final anchor = parseYmd(source.anchorDate!);
        final weekday = anchor.weekday;
        dates = <DateTime>[];
        for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
          if (d.weekday == weekday) dates.add(d);
        }
        break;

      case 'biweekly':
        if (source.anchorDate == null) return [];
        final anchor = parseYmd(source.anchorDate!);
        dates = <DateTime>[];
        for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
          final diffDays = d.difference(DateTime(anchor.year, anchor.month, anchor.day)).inDays;
          if (diffDays >= 0 && diffDays % 14 == 0) dates.add(d);
        }
        break;

      case 'semimonthly':
        // Default to 1st and 15th
        int day1 = 1;
        int day2 = 15;
        if (source.anchorDate != null) {
          // Could parse custom days from anchor, but for now use defaults
        }
        dates = <DateTime>[];
        dates.add(DateTime(year, month, day1.clamp(1, end.day)));
        dates.add(DateTime(year, month, day2.clamp(1, end.day)));
        break;

      case 'yearly':
        if (source.anchorDate == null) return [];
        final anchor = parseYmd(source.anchorDate!);
        if (anchor.month != month) return [];
        final clampedDay = anchor.day.clamp(1, end.day);
        dates = [DateTime(year, month, clampedDay)];
        break;

      case 'one_time':
        // One-time income is added directly as an instance, not generated
        return [];

      default:
        return [];
    }

    final startLimit = source.startDate != null ? parseYmd(source.startDate!) : null;
    if (startLimit == null) return dates;
    return dates.where((d) => !d.isBefore(startLimit)).toList();
  }

  /// Generate instances for current and next month
  Future<void> ensureCurrentAndNextMonthGenerated() async {
    final now = DateTime.now();
    await ensureMonthGenerated(now.year, now.month);
    
    // Next month
    final nextMonth = DateTime(now.year, now.month + 1, 1);
    await ensureMonthGenerated(nextMonth.year, nextMonth.month);
  }
}
