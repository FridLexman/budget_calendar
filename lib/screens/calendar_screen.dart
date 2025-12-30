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
  
  @override
  Widget build(BuildContext context) {
    final dbAsync = ref.watch(appDatabaseProvider);
    final selectedDay = ref.watch(selectedDateProvider);
    final focusedMonth = ref.watch(selectedMonthProvider);

    return dbAsync.when(
      data: (db) {
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
          body: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: focusedMonth,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.twoWeeks: '2 Weeks',
                  CalendarFormat.week: 'Week',
                },
                selectedDayPredicate: (d) => isSameDay(d, selectedDay),
                onDaySelected: (sel, foc) {
                  ref.read(selectedDateProvider.notifier).state = sel;
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => DayDetailScreen(date: sel)),
                  );
                },
                onFormatChanged: (format) {
                  setState(() => _calendarFormat = format);
                },
                onPageChanged: (foc) async {
                  ref.read(selectedMonthProvider.notifier).state = DateTime(foc.year, foc.month, 1);
                  // Generate instances for the new month
                  await MonthGenerator(db).ensureMonthGenerated(foc.year, foc.month);
                },
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
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    final dateStr = ymd(day);
                    return FutureBuilder<_DayInfo>(
                      future: _getDayInfo(db, dateStr),
                      builder: (context, snap) {
                        if (!snap.hasData) return const SizedBox.shrink();
                        final info = snap.data!;
                        if (info.count == 0) return const SizedBox.shrink();
                        
                        return Positioned(
                          bottom: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: info.hasPaid 
                                      ? Colors.green 
                                      : Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${info.count}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              // Show selected day summary
              Expanded(
                child: _buildDaySummary(db, selectedDay),
              ),
            ],
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

  Widget _buildDaySummary(AppDatabase db, DateTime day) {
    final dateStr = ymd(day);
    
    return StreamBuilder<List<BillInstance>>(
      stream: db.watchBillInstancesForDate(dateStr),
      builder: (context, snap) {
        final rows = snap.data ?? [];
        
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DayDetailScreen(date: day)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<_DayInfo> _getDayInfo(AppDatabase db, String dateStr) async {
    final bills = await db.getBillInstancesForDate(dateStr);
    final hasPaid = bills.any((b) => b.status == 'paid' || b.status == 'partial');
    return _DayInfo(count: bills.length, hasPaid: hasPaid);
  }
}

class _DayInfo {
  final int count;
  final bool hasPaid;
  _DayInfo({required this.count, required this.hasPaid});
}
