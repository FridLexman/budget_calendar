import 'dart:convert';
import '../utils/date_utils.dart';

/// Recurrence JSON examples:
/// Monthly: {"type":"monthly","day":1}
/// Weekly: {"type":"weekly","weekday":5}   // 1=Mon..7=Sun (DateTime.weekday)
/// Biweekly: {"type":"biweekly","anchor":"2025-01-03"} // uses anchor date
/// Yearly: {"type":"yearly","month":12,"day":25}
/// Semi-monthly: {"type":"semimonthly","day1":1,"day2":15}
class Recurrence {
  final String type;
  final Map<String, dynamic> raw;

  Recurrence(this.type, this.raw);

  static Recurrence? fromJsonString(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return null;
    try {
      final m = json.decode(jsonStr) as Map<String, dynamic>;
      final type = (m['type'] as String?) ?? '';
      if (type.isEmpty) return null;
      return Recurrence(type, m);
    } catch (e) {
      return null;
    }
  }

  List<DateTime> occurrencesInMonth(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0);

    switch (type) {
      case 'monthly':
        final day = (raw['day'] as num).toInt();
        final clampedDay = day.clamp(1, end.day);
        return [DateTime(year, month, clampedDay)];

      case 'yearly':
        final m = (raw['month'] as num).toInt();
        final d = (raw['day'] as num).toInt();
        if (m != month) return [];
        final last = DateTime(year, month + 1, 0).day;
        return [DateTime(year, month, d.clamp(1, last))];

      case 'weekly':
        final weekday = (raw['weekday'] as num).toInt();
        final dates = <DateTime>[];
        for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
          if (d.weekday == weekday) dates.add(d);
        }
        return dates;

      case 'biweekly':
        final anchorStr = raw['anchor'] as String?;
        if (anchorStr == null) return [];
        final anchor = parseYmd(anchorStr);
        final dates = <DateTime>[];
        for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
          final diffDays = d.difference(DateTime(anchor.year, anchor.month, anchor.day)).inDays;
          if (diffDays >= 0 && diffDays % 14 == 0) dates.add(d);
        }
        return dates;

      case 'semimonthly':
        final day1 = (raw['day1'] as num?)?.toInt() ?? 1;
        final day2 = (raw['day2'] as num?)?.toInt() ?? 15;
        final dates = <DateTime>[];
        final clampedDay1 = day1.clamp(1, end.day);
        final clampedDay2 = day2.clamp(1, end.day);
        dates.add(DateTime(year, month, clampedDay1));
        if (clampedDay1 != clampedDay2) {
          dates.add(DateTime(year, month, clampedDay2));
        }
        dates.sort((a, b) => a.compareTo(b));
        return dates;

      case 'lastday':
        return [end];

      case 'lastbusinessday':
        var lastBiz = end;
        while (lastBiz.weekday == DateTime.saturday || lastBiz.weekday == DateTime.sunday) {
          lastBiz = lastBiz.subtract(const Duration(days: 1));
        }
        return [lastBiz];

      default:
        return [];
    }
  }

  String get displayName {
    switch (type) {
      case 'monthly':
        final day = (raw['day'] as num).toInt();
        return 'Monthly on day $day';
      case 'yearly':
        final m = (raw['month'] as num).toInt();
        final d = (raw['day'] as num).toInt();
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return 'Yearly on ${months[m - 1]} $d';
      case 'weekly':
        final weekday = (raw['weekday'] as num).toInt();
        return 'Weekly on ${weekdayName(weekday)}';
      case 'biweekly':
        return 'Every 2 weeks';
      case 'semimonthly':
        final day1 = (raw['day1'] as num?)?.toInt() ?? 1;
        final day2 = (raw['day2'] as num?)?.toInt() ?? 15;
        return 'Semi-monthly (${day1}th & ${day2}th)';
      case 'lastday':
        return 'Last day of month';
      case 'lastbusinessday':
        return 'Last business day';
      default:
        return 'Unknown';
    }
  }

  static String toMonthly({required int dayOfMonth}) =>
      json.encode({'type': 'monthly', 'day': dayOfMonth});

  static String toWeekly({required int weekday}) =>
      json.encode({'type': 'weekly', 'weekday': weekday});

  static String toBiweekly({required DateTime anchor}) =>
      json.encode({'type': 'biweekly', 'anchor': ymd(anchor)});

  static String toYearly({required int month, required int day}) =>
      json.encode({'type': 'yearly', 'month': month, 'day': day});

  static String toSemiMonthly({required int day1, required int day2}) =>
      json.encode({'type': 'semimonthly', 'day1': day1, 'day2': day2});

  static String toLastDay() => json.encode({'type': 'lastday'});

  static String toLastBusinessDay() => json.encode({'type': 'lastbusinessday'});
}
