import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../state/db_providers.dart';
import '../state/selection_providers.dart';
import '../db/app_database.dart';
import '../features/month_generator.dart';
import 'day_detail_screen.dart';
import '../utils/date_utils.dart';
import '../utils/money.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _initialized = false;
  bool _isLoadingMonth = false;
  final Map<String, List<BillInstance>> _monthCache = {};

  String _monthKey(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}';

  Future<void> _loadMonth(AppDatabase db, DateTime month, {bool prefetchNext = false}) async {
    final key = _monthKey(month);
    if (_monthCache.containsKey(key) && !prefetchNext) return;
    setState(() => _isLoadingMonth = true);

    // Ensure generated and then fetch for this month
    await MonthGenerator(db).ensureMonthGenerated(month.year, month.month);
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0);
    final rows = await db.getBillInstancesForMonth(ymd(start), ymd(end));

    setState(() {
      _monthCache[key] = rows;
      _isLoadingMonth = false;
    });

    if (prefetchNext) {
      final next = DateTime(month.year, month.month + 1, 1);
      final nextKey = _monthKey(next);
      if (!_monthCache.containsKey(nextKey)) {
        // fire-and-forget without flipping the loading indicator
        MonthGenerator(db).ensureMonthGenerated(next.year, next.month).then((_) async {
          final nStart = DateTime(next.year, next.month, 1);
          final nEnd = DateTime(next.year, next.month + 1, 0);
          final nRows = await db.getBillInstancesForMonth(ymd(nStart), ymd(nEnd));
          if (mounted) {
            setState(() {
              _monthCache[nextKey] = nRows;
            });
          }
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final dbAsync = ref.watch(appDatabaseProvider);
    final selectedDay = ref.watch(selectedDateProvider);
    final focusedMonth = ref.watch(selectedMonthProvider);

    return dbAsync.when(
      data: (db) {
        if (!_initialized) {
          _initialized = true;
          _loadMonth(db, focusedMonth, prefetchNext: true);
        }

        final monthRows = _monthCache[_monthKey(focusedMonth)] ?? const <BillInstance>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Calendar'),
            actions: [
              IconButton(
                icon: const Icon(Icons.today),
                tooltip: 'Go to today',
                onPressed: () {
                  final now = DateTime.now();
                  ref.read(selectedDateProvider.notifier).state = now;
                  ref.read(selectedMonthProvider.notifier).state = DateTime(now.year, now.month, 1);
                },
              ),
            ],
          ),
          body: _CalendarBody(
            db: db,
            focusedMonth: focusedMonth,
            selectedDay: selectedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (f) => setState(() => _calendarFormat = f),
            onDaySelected: (d) {
              ref.read(selectedDateProvider.notifier).state = d;
              ref.read(selectedMonthProvider.notifier).state = DateTime(d.year, d.month, 1);
            },
            onMonthChanged: (m) {
              ref.read(selectedMonthProvider.notifier).state = m;
              _loadMonth(db, m, prefetchNext: true);
            },
            monthRows: monthRows,
            isLoadingMonth: _isLoadingMonth,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DayDetailScreen(date: selectedDay)),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Bill'),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Future<_DayInfo> _getDayInfo(AppDatabase db, String dateStr) async {
    final bills = await db.getBillInstancesForDate(dateStr);
    final hasPaid = bills.any((b) => b.status == 'paid' || b.status == 'partial');
    return _DayInfo(count: bills.length, hasPaid: hasPaid);
  }
}

class _CalendarBody extends StatelessWidget {
  final AppDatabase db;
  final DateTime focusedMonth;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final void Function(CalendarFormat) onFormatChanged;
  final void Function(DateTime) onDaySelected;
  final void Function(DateTime) onMonthChanged;
  final List<BillInstance> monthRows;
  final bool isLoadingMonth;

  const _CalendarBody({
    required this.db,
    required this.focusedMonth,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onFormatChanged,
    required this.onDaySelected,
    required this.onMonthChanged,
    required this.monthRows,
    required this.isLoadingMonth,
  });

  @override
  Widget build(BuildContext context) {
    final markers = <String, _DayInfo>{};
    for (final b in monthRows.where((r) => r.status != 'skipped')) {
      final info = markers.putIfAbsent(b.dueDate, () => _DayInfo(count: 0, hasPaid: false));
      markers[b.dueDate] = _DayInfo(
        count: info.count + 1,
        hasPaid: info.hasPaid || b.status == 'paid' || b.status == 'partial',
      );
    }

    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: focusedMonth,
          calendarFormat: calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.twoWeeks: '2 Weeks',
            CalendarFormat.week: 'Week',
          },
          selectedDayPredicate: (d) => isSameDay(d, selectedDay),
          eventLoader: (d) {
            final dateStr = ymd(d);
            final rowsForDay =
                monthRows.where((r) => r.dueDate == dateStr && r.status != 'skipped').toList();
            return rowsForDay;
          },
          onDaySelected: (sel, foc) => onDaySelected(sel),
          onFormatChanged: onFormatChanged,
          onPageChanged: (foc) async {
            onMonthChanged(DateTime(foc.year, foc.month, 1));
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              final info = markers[ymd(day)];
              if (info == null || info.count == 0) return const SizedBox.shrink();
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 18,
                  height: 14,
                  decoration: BoxDecoration(
                    color: info.hasPaid
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${info.count}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: _MonthSummaryBanner(rows: monthRows),
        ),
        const Divider(height: 1),
        Expanded(
          child: isLoadingMonth
              ? const Center(child: CircularProgressIndicator())
              : _buildDaySummaryFromMonth(context, monthRows, selectedDay),
        ),
      ],
    );
  }
}

class _DayInfo {
  final int count;
  final bool hasPaid;
  _DayInfo({required this.count, required this.hasPaid});
}

class _MonthSummaryBanner extends StatelessWidget {
  final List<BillInstance> rows;
  const _MonthSummaryBanner({required this.rows});

  @override
  Widget build(BuildContext context) {
    final preview = rows.take(5).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This month: ${rows.length} bill instances',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        if (preview.isNotEmpty)
          ...preview.map((b) => Text(
                '${b.dueDate}: ${b.titleSnapshot}',
                style: Theme.of(context).textTheme.bodySmall,
              )),
        if (preview.isEmpty)
          Text(
            'No instances loaded for this month',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

Widget _buildDaySummaryFromMonth(BuildContext context, List<BillInstance> monthRows, DateTime day) {
  final dateStr = ymd(day);
  final rows = monthRows.where((r) => r.dueDate == dateStr && r.status != 'skipped').toList();

  if (rows.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'No bills on ${formatDateShort(day)}',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  final total = rows.fold<int>(0, (a, b) => a + b.amountCents);
  final paidTotal = rows
      .where((r) => r.status == 'paid' || r.status == 'partial')
      .fold<int>(0, (a, b) => a + (b.paidAmountCents ?? b.amountCents));

  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatDateLong(day),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Due: ${formatCents(total)}'),
                if (paidTotal > 0)
                  Text(
                    'Paid: ${formatCents(paidTotal)}',
                    style: const TextStyle(color: Colors.green),
                  ),
              ],
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: rows.length,
          itemBuilder: (context, index) {
            final bill = rows[index];
            final isPaid = bill.status == 'paid';
            final isPartial = bill.status == 'partial';

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: isPaid
                    ? Colors.green
                    : isPartial
                        ? Colors.orange
                        : Colors.grey[300],
                child: Icon(
                  isPaid ? Icons.check : Icons.receipt,
                  color: isPaid || isPartial ? Colors.white : Colors.grey[600],
                ),
              ),
              title: Text(
                bill.titleSnapshot,
                style: TextStyle(
                  decoration: isPaid ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(bill.category ?? 'Uncategorized'),
              trailing: Text(
                formatCents(bill.amountCents),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPaid ? Colors.green : null,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DayDetailScreen(date: day)));
              },
            );
          },
        ),
      ),
    ],
  );
}
