import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/db_providers.dart';
import '../state/selection_providers.dart';
import '../utils/money.dart';
import '../utils/date_utils.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(appDatabaseProvider);
    final selectedMonth = ref.watch(selectedMonthProvider);

    return dbAsync.when(
      data: (db) {
        final start = startOfMonth(selectedMonth);
        final end = endOfMonth(selectedMonth);
        final startStr = ymd(start);
        final endStr = ymd(end);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  ref.read(selectedMonthProvider.notifier).state = 
                      DateTime(selectedMonth.year, selectedMonth.month - 1, 1);
                },
              ),
              TextButton(
                onPressed: () {
                  ref.read(selectedMonthProvider.notifier).state = 
                      DateTime(DateTime.now().year, DateTime.now().month, 1);
                },
                child: Text(formatMonthYear(selectedMonth)),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  ref.read(selectedMonthProvider.notifier).state = 
                      DateTime(selectedMonth.year, selectedMonth.month + 1, 1);
                },
              ),
            ],
          ),
          body: FutureBuilder<_DashboardData>(
            future: _loadDashboardData(db, startStr, endStr),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final d = snap.data!;
              final moneyLeftProjected = d.incomeProjected - d.billsScheduled;
              final moneyLeftActual = d.incomeReceived - d.billsPaid;

              return RefreshIndicator(
                onRefresh: () async {
                  // Trigger rebuild
                  ref.invalidate(appDatabaseProvider);
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Summary Cards
                    _buildSummaryCard(
                      context,
                      title: 'Money Left (Projected)',
                      value: formatCents(moneyLeftProjected),
                      color: moneyLeftProjected >= 0 ? Colors.green : Colors.red,
                      icon: Icons.trending_up,
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryCard(
                      context,
                      title: 'Money Left (Actual)',
                      value: formatCents(moneyLeftActual),
                      color: moneyLeftActual >= 0 ? Colors.green : Colors.red,
                      icon: Icons.account_balance_wallet,
                    ),
                    const SizedBox(height: 24),

                    // Income vs Bills breakdown
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Monthly Breakdown',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildBreakdownRow(
                              'Income (Projected)',
                              formatCents(d.incomeProjected),
                              Colors.green,
                            ),
                            _buildBreakdownRow(
                              'Income (Received)',
                              formatCents(d.incomeReceived),
                              Colors.green.shade700,
                            ),
                            const Divider(height: 24),
                            _buildBreakdownRow(
                              'Bills (Scheduled)',
                              formatCents(d.billsScheduled),
                              Colors.orange,
                            ),
                            _buildBreakdownRow(
                              'Bills (Paid)',
                              formatCents(d.billsPaid),
                              Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Next 7 days
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Next 7 Days',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${d.next7Count} bills due'),
                                Text(
                                  formatCents(d.next7Total),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category breakdown
                    if (d.categoryBreakdown.isNotEmpty)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Spending by Category',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...d.categoryBreakdown.entries.map((e) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.key),
                                    Text(formatCents(e.value)),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Future<_DashboardData> _loadDashboardData(dynamic db, String startStr, String endStr) async {
    final summary = await db.getMonthSummary(startStr, endStr);
    
    final now = DateTime.now();
    final next7End = now.add(const Duration(days: 7));
    final next7Summary = await db.getNext7DaysSummary(ymd(now), ymd(next7End));
    
    final categoryBreakdown = await db.getCategoryBreakdown(startStr, endStr);

    return _DashboardData(
      billsScheduled: summary['billsScheduled'] ?? 0,
      billsPaid: summary['billsPaid'] ?? 0,
      incomeProjected: summary['incomeProjected'] ?? 0,
      incomeReceived: summary['incomeReceived'] ?? 0,
      next7Count: next7Summary['count'] ?? 0,
      next7Total: next7Summary['total'] ?? 0,
      categoryBreakdown: categoryBreakdown,
    );
  }
}

class _DashboardData {
  final int billsScheduled;
  final int billsPaid;
  final int incomeProjected;
  final int incomeReceived;
  final int next7Count;
  final int next7Total;
  final Map<String, int> categoryBreakdown;

  _DashboardData({
    required this.billsScheduled,
    required this.billsPaid,
    required this.incomeProjected,
    required this.incomeReceived,
    required this.next7Count,
    required this.next7Total,
    required this.categoryBreakdown,
  });
}
