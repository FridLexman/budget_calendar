import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/db_providers.dart';
import '../db/app_database.dart';
import '../features/month_generator.dart';
import '../utils/money.dart';
import '../utils/date_utils.dart';

class IncomeScreen extends ConsumerStatefulWidget {
  const IncomeScreen({super.key});

  @override
  ConsumerState<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends ConsumerState<IncomeScreen> {
  final Set<int> _selectedIncomeIds = {};
  String _incomeStatusFilter = 'all';
  bool _incomeAllMonths = false;

  @override
  Widget build(BuildContext context) {
    final dbAsync = ref.watch(appDatabaseProvider);

    return dbAsync.when(
      data: (db) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Income'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Instances'),
                Tab(text: 'Sources'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildInstancesTab(context, db),
              _buildSourcesTab(context, db),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddIncomeDialog(context, db),
            icon: const Icon(Icons.add),
            label: const Text('Add income'),
          ),
        ),
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildInstancesTab(BuildContext context, AppDatabase db) {
    final now = DateTime.now();
    final startDate = ymd(DateTime(now.year, now.month, 1));
    final endDate = ymd(DateTime(now.year, now.month + 1, 0));
    final stream = _incomeAllMonths
        ? db.watchAllIncomeInstances()
        : db.watchIncomeInstancesForMonth(startDate, endDate);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<String>(
                  value: _incomeStatusFilter,
                  decoration: const InputDecoration(labelText: 'Status filter'),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All')),
                    DropdownMenuItem(
                        value: 'expected', child: Text('Expected')),
                    DropdownMenuItem(
                        value: 'received', child: Text('Received')),
                    DropdownMenuItem(value: 'skipped', child: Text('Skipped')),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _incomeStatusFilter = v;
                      _selectedIncomeIds.clear();
                    });
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('All months'),
                  Switch(
                    value: _incomeAllMonths,
                    onChanged: (v) {
                      setState(() {
                        _incomeAllMonths = v;
                        _selectedIncomeIds.clear();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_selectedIncomeIds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => _deleteSelectedIncomes(db),
                  icon: const Icon(Icons.delete),
                  label: Text('Delete selected (${_selectedIncomeIds.length})'),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIncomeIds.clear();
                    });
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
        Expanded(
          child: StreamBuilder(
            stream: stream,
            builder: (context, snap) {
              final rows = snap.data ?? [];
              final filtered = rows.where((r) {
                if (_incomeStatusFilter == 'all') return true;
                return r.status == _incomeStatusFilter;
              }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payments, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('No income entries match the filter.'),
                    ],
                  ),
                );
              }

              final grouped = <String, List<IncomeInstance>>{};
              for (final r in filtered) {
                final date = parseYmd(r.date);
                final key = formatMonthYear(date);
                grouped.putIfAbsent(key, () => []).add(r);
              }

              final itemCount =
                  grouped.length + (_selectedIncomeIds.isNotEmpty ? 1 : 0);

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (_selectedIncomeIds.isNotEmpty && index == 0) {
                    return const SizedBox.shrink();
                  }

                  final monthIndex =
                      _selectedIncomeIds.isNotEmpty ? index - 1 : index;
                  final monthKey = grouped.keys.elementAt(monthIndex);
                  final monthRows = grouped[monthKey]!;
                  final monthTotal =
                      monthRows.fold<int>(0, (a, b) => a + b.amountCents);
                  final receivedTotal = monthRows
                      .where((r) => r.status == 'received')
                      .fold<int>(0, (a, b) => a + b.amountCents);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              monthKey,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Expected: ${formatCents(monthTotal)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Received: ${formatCents(receivedTotal)}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ...monthRows.map(
                        (r) => _buildIncomeCard(
                          context,
                          db,
                          r,
                          _selectedIncomeIds.contains(r.id),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSourcesTab(BuildContext context, AppDatabase db) {
    return StreamBuilder(
      stream: db.watchAllIncomeSources(),
      builder: (context, snap) {
        final rows = snap.data ?? [];
        if (rows.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text('No income sources yet.'),
                const SizedBox(height: 8),
                const Text(
                  'Add recurring income sources\nto auto-generate income entries.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => _showAddIncomeSourceDialog(context, db),
                  icon: const Icon(Icons.add),
                  label: const Text('Add income source'),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ...rows.map((s) => _buildSourceCard(context, db, s)),
            const SizedBox(height: 80),
          ],
        );
      },
    );
  }

  Widget _buildIncomeCard(BuildContext context, AppDatabase db,
      IncomeInstance income, bool selected) {
    final isReceived = income.status == 'received';
    final isSkipped = income.status == 'skipped';

    return Card(
      color: isSkipped ? Colors.grey[100] : null,
      child: InkWell(
        onTap: _selectedIncomeIds.isNotEmpty
            ? () => _toggleIncomeSelect(income.id)
            : () => _showIncomeActions(context, db, income),
        onLongPress: () => _toggleIncomeSelect(income.id),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Checkbox(
                value: selected,
                onChanged: (_) => _toggleIncomeSelect(income.id),
              ),
              const SizedBox(width: 8),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSkipped
                      ? Colors.grey[300]
                      : isReceived
                          ? Colors.green
                          : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSkipped
                      ? Icons.skip_next
                      : isReceived
                          ? Icons.check
                          : Icons.schedule,
                  color: isSkipped || !isReceived
                      ? Colors.grey[600]
                      : Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      income.titleSnapshot,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration:
                            isSkipped ? TextDecoration.lineThrough : null,
                        color: isSkipped ? Colors.grey : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${income.date} • ${isReceived ? "Received" : isSkipped ? "Skipped" : "Expected"}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isReceived ? Colors.green : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatCents(income.amountCents),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSkipped
                      ? Colors.grey
                      : isReceived
                          ? Colors.green
                          : null,
                  decoration: isSkipped ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleIncomeSelect(int id) {
    setState(() {
      if (_selectedIncomeIds.contains(id)) {
        _selectedIncomeIds.remove(id);
      } else {
        _selectedIncomeIds.add(id);
      }
    });
  }

  Future<void> _deleteSelectedIncomes(AppDatabase db) async {
    final ids = List<int>.from(_selectedIncomeIds);
    for (final id in ids) {
      await db.deleteIncomeInstance(id);
    }
    setState(() {
      _selectedIncomeIds.clear();
    });
  }

  Widget _buildSourceCard(
      BuildContext context, AppDatabase db, IncomeSource source) {
    String frequencyText;
    switch (source.frequency) {
      case 'monthly':
        frequencyText = 'Monthly';
        break;
      case 'weekly':
        frequencyText = 'Weekly';
        break;
      case 'biweekly':
        frequencyText = 'Biweekly';
        break;
      case 'semimonthly':
        frequencyText = 'Semi-monthly';
        break;
      case 'yearly':
        frequencyText = 'Yearly';
        break;
      default:
        frequencyText = source.frequency;
    }

    return Card(
      color: source.active ? null : Colors.grey[100],
      child: InkWell(
        onTap: () => _showSourceActions(context, db, source),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: source.active
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.repeat,
                  color: source.active
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: source.active ? null : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      frequencyText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (source.startDate != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Starts ${source.startDate}',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                formatCents(source.amountCents),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: source.active ? null : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIncomeActions(
      BuildContext context, AppDatabase db, IncomeInstance income) {
    final isReceived = income.status == 'received';
    final isSkipped = income.status == 'skipped';

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                income.titleSnapshot,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('${income.date} • ${formatCents(income.amountCents)}'),
            ),
            const Divider(),
            if (!isReceived && !isSkipped)
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Mark as Received'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.markIncomeReceived(instanceId: income.id);
                },
              ),
            if (isReceived)
              ListTile(
                leading: const Icon(Icons.undo, color: Colors.blue),
                title: const Text('Mark as Expected'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.markIncomeExpected(instanceId: income.id);
                },
              ),
            if (!isSkipped)
              ListTile(
                leading: const Icon(Icons.skip_next, color: Colors.grey),
                title: const Text('Skip'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.skipIncomeInstance(instanceId: income.id);
                },
              ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit Amount'),
              onTap: () {
                Navigator.pop(context);
                _showEditIncomeAmountDialog(context, db, income);
              },
            ),
            if (income.sourceId == null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.deleteIncomeInstance(income.id);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSourceActions(
      BuildContext context, AppDatabase db, IncomeSource source) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                source.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(formatCents(source.amountCents)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showEditIncomeSourceDialog(context, db, source);
              },
            ),
            ListTile(
              leading: const Icon(Icons.clear_all, color: Colors.redAccent),
              title: const Text('Delete all instances for this source'),
              subtitle: const Text('Removes all generated income entries'),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete all income instances'),
                    content: Text(
                        'Delete every income instance created from "${source.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        style:
                            FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete all'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await db.deleteIncomeInstancesForSource(source.id);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete'),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Income Source'),
                    content: Text('Delete "${source.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        style:
                            FilledButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await db.deleteIncomeSource(source.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditIncomeAmountDialog(
      BuildContext context, AppDatabase db, IncomeInstance income) {
    final controller =
        TextEditingController(text: centsToInputString(income.amountCents));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Amount'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Amount',
            prefixText: '\$',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final cents = parseDollarsToCents(controller.text);
              if (cents > 0) {
                await db.updateIncomeInstanceAmount(
                  instanceId: income.id,
                  amountCents: cents,
                );
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddIncomeDialog(
      BuildContext context, AppDatabase db) async {
    final isRecurring = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Income'),
        content: const Text('Is this recurring income or a one-time payment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('One-time'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Recurring'),
          ),
        ],
      ),
    );

    if (isRecurring == null) return;

    if (isRecurring) {
      if (context.mounted) {
        _showAddIncomeSourceDialog(context, db);
      }
    } else {
      if (context.mounted) {
        _showAddOneTimeIncomeDialog(context, db);
      }
    }
  }

  Future<void> _showAddOneTimeIncomeDialog(
      BuildContext context, AppDatabase db) async {
    final nameCtrl = TextEditingController(text: 'Paycheck');
    final amtCtrl = TextEditingController();
    DateTime chosen = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add One-Time Income'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amtCtrl,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text('Date: ${ymd(chosen)}')),
                  TextButton(
                    onPressed: () async {
                      final p = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2100, 12, 31),
                        initialDate: chosen,
                      );
                      if (p != null) setState(() => chosen = p);
                    },
                    child: const Text('Pick'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final cents = parseDollarsToCents(amtCtrl.text.trim());
                if (name.isEmpty || cents <= 0) return;
                await db.addOneTimeIncomeInstance(
                  title: name,
                  amountCents: cents,
                  date: ymd(chosen),
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddIncomeSourceDialog(
      BuildContext context, AppDatabase db) async {
    final nameCtrl = TextEditingController();
    final amtCtrl = TextEditingController();
    String frequency = 'biweekly';
    DateTime anchorDate = DateTime.now();
    DateTime startDate = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Income Source'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Name (e.g., Salary)'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: amtCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Amount per payment',
                    prefixText: '\$',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: frequency,
                  decoration: const InputDecoration(labelText: 'Frequency'),
                  items: const [
                    DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                    DropdownMenuItem(
                        value: 'biweekly', child: Text('Biweekly')),
                    DropdownMenuItem(
                        value: 'semimonthly',
                        child: Text('Semi-monthly (1st & 15th)')),
                    DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                    DropdownMenuItem(value: 'yearly', child: Text('Yearly')),
                  ],
                  onChanged: (v) => setState(() => frequency = v ?? 'biweekly'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        frequency == 'semimonthly'
                            ? 'Pays on 1st & 15th'
                            : 'Anchor: ${ymd(anchorDate)}',
                      ),
                    ),
                    if (frequency != 'semimonthly')
                      TextButton(
                        onPressed: () async {
                          final p = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000, 1, 1),
                            lastDate: DateTime(2100, 12, 31),
                            initialDate: anchorDate,
                          );
                          if (p != null) setState(() => anchorDate = p);
                        },
                        child: const Text('Pick'),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text('Start date: ${ymd(startDate)}')),
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000, 1, 1),
                          lastDate: DateTime(2100, 12, 31),
                          initialDate: startDate,
                        );
                        if (picked != null) setState(() => startDate = picked);
                      },
                      child: const Text('Pick'),
                    ),
                  ],
                ),
                const Text(
                  'Income will only generate on or after this date.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (frequency == 'biweekly')
                  const Text(
                    'Pick a recent pay date. Income will repeat every 2 weeks.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final cents = parseDollarsToCents(amtCtrl.text.trim());
                if (name.isEmpty || cents <= 0) return;

                await db.upsertIncomeSource(
                  name: name,
                  amountCents: cents,
                  frequency: frequency,
                  startDate: ymd(startDate),
                  anchorDate: ymd(anchorDate),
                );

                // Generate instances
                final now = DateTime.now();
                final generator = MonthGenerator(db);
                await generator.ensureMonthGenerated(now.year, now.month);
                await generator.ensureMonthGenerated(now.year, now.month + 1);

                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditIncomeSourceDialog(
      BuildContext context, AppDatabase db, IncomeSource source) async {
    final nameCtrl = TextEditingController(text: source.name);
    final amtCtrl =
        TextEditingController(text: centsToInputString(source.amountCents));
    DateTime startDate =
        source.startDate != null ? parseYmd(source.startDate!) : DateTime.now();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Income Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amtCtrl,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: Text('Start date: ${ymd(startDate)}')),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2100, 12, 31),
                        initialDate: startDate,
                      );
                      if (picked != null) setState(() => startDate = picked);
                    },
                    child: const Text('Pick'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final cents = parseDollarsToCents(amtCtrl.text.trim());
                if (name.isEmpty || cents <= 0) return;

                await db.upsertIncomeSource(
                  id: source.id,
                  name: name,
                  amountCents: cents,
                  frequency: source.frequency,
                  startDate: ymd(startDate),
                  anchorDate: source.anchorDate,
                  active: source.active,
                );

                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
