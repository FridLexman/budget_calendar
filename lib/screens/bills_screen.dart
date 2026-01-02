import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/db_providers.dart';
import '../db/app_database.dart';
import '../features/recurrence.dart';
import '../features/month_generator.dart';
import '../utils/money.dart';
import '../utils/date_utils.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(appDatabaseProvider);

    return dbAsync.when(
      data: (db) => Scaffold(
        appBar: AppBar(
          title: const Text('Bills'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () => _showHelpDialog(context),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: db.watchAllBillTemplates(),
          builder: (context, snap) {
            final rows = snap.data ?? [];
            final activeTemplates = rows.where((t) => t.active).toList();
            final inactiveTemplates = rows.where((t) => !t.active).toList();

            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (rows.isEmpty) ...[
                  Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.receipt_long,
                                  size: 32, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              const Text(
                                'No recurring bills yet',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Add a recurring bill to automatically generate future instances.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 12),
                          FilledButton.icon(
                            onPressed: () => _showAddBillFlow(context, db),
                            icon: const Icon(Icons.add),
                            label: const Text('Add recurring bill'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (activeTemplates.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Active (${activeTemplates.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  ...activeTemplates
                      .map((t) => _buildTemplateCard(context, db, t)),
                ],
                if (inactiveTemplates.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Inactive (${inactiveTemplates.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  ...inactiveTemplates
                      .map((t) => _buildTemplateCard(context, db, t)),
                ],
                const SizedBox(height: 16),
                _buildInstancesSection(
                  context: context,
                  db: db,
                  startDate: ymd(DateTime.now().copyWith(day: 1)),
                  endDate: ymd(DateTime(
                      DateTime.now().year, DateTime.now().month + 1, 0)),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddBillFlow(context, db),
          icon: const Icon(Icons.add),
          label: const Text('Add bill'),
        ),
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildTemplateCard(
      BuildContext context, AppDatabase db, BillTemplate template) {
    final rec = Recurrence.fromJsonString(template.recurrenceRule);
    final recurrenceText = rec?.displayName ?? 'No recurrence';

    return Card(
      color: template.active ? null : Colors.grey[100],
      child: InkWell(
        onTap: () => _showTemplateActions(context, db, template),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: template.active
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.repeat,
                  color: template.active
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
                      template.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: template.active ? null : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (template.category != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              template.category!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          recurrenceText,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    if (template.startDate != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Starts ${template.startDate}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                formatCents(template.defaultAmountCents),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: template.active ? null : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstancesSection({
    required BuildContext context,
    required AppDatabase db,
    required String startDate,
    required String endDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'This month' 's instances',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        StreamBuilder<List<BillInstance>>(
          stream: db.watchBillInstancesForMonth(startDate, endDate),
          builder: (context, snap) {
            final rows = snap.data ?? const <BillInstance>[];
            if (rows.isEmpty) {
              return const Text(
                  'No bill instances found in the local database.');
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rows.length,
              itemBuilder: (context, idx) {
                final b = rows[idx];
                final isPaid = b.status == 'paid';
                final isPartial = b.status == 'partial';
                final isSkipped = b.status == 'skipped';
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Icon(
                      isPaid
                          ? Icons.check_circle
                          : isPartial
                              ? Icons.adjust
                              : isSkipped
                                  ? Icons.remove_circle
                                  : Icons.schedule,
                      color: isPaid
                          ? Colors.green
                          : isPartial
                              ? Colors.orange
                              : isSkipped
                                  ? Colors.grey
                                  : Colors.grey[600],
                    ),
                    title: Text(b.titleSnapshot),
                    subtitle:
                        Text('${b.dueDate} - ${b.category ?? 'Uncategorized'}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCents(b.amountCents),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isPaid ? Colors.green : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _statusColor(context, b.status)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            b.status,
                            style: TextStyle(
                              fontSize: 11,
                              color: _statusColor(context, b.status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showInstanceActions(context, db, b),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showTemplateActions(
      BuildContext context, AppDatabase db, BillTemplate template) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                template.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(formatCents(template.defaultAmountCents)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showEditTemplateDialog(context, db, template);
              },
            ),
            ListTile(
              leading: Icon(
                template.active ? Icons.pause : Icons.play_arrow,
                color: template.active ? Colors.orange : Colors.green,
              ),
              title: Text(template.active ? 'Deactivate' : 'Activate'),
              subtitle: Text(
                template.active
                    ? 'Stop generating new instances'
                    : 'Resume generating instances',
              ),
              onTap: () async {
                Navigator.pop(context);
                await db.toggleBillTemplateActive(
                    template.id, !template.active);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete'),
              subtitle: const Text('This will not delete existing instances'),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Template'),
                    content: Text(
                      'Delete "${template.name}"?\n\n'
                      'Existing bill instances will not be deleted.',
                    ),
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
                  await db.deleteBillTemplate(template.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Bill Templates'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Recurring Bills',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Templates define recurring bills that automatically generate '
                'instances on your calendar each month.',
              ),
              SizedBox(height: 16),
              Text(
                'One-Time Bills',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'For one-time bills, add them directly from the Calendar by '
                'tapping a day and using "Add bill".',
              ),
              SizedBox(height: 16),
              Text(
                'Recurrence Options',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Monthly (specific day)\n'
                  '• Weekly (specific weekday)\n'
                  '• Biweekly (every 2 weeks)\n'
                  '• Semi-monthly (1st & 15th)\n'
                  '• Yearly\n'
                  '• Last day of month\n'
                  '• Last business day'),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddBillFlow(BuildContext context, AppDatabase db) async {
    final nameCtrl = TextEditingController();
    final amtCtrl = TextEditingController();
    String? selectedCategory;
    int recurrenceTypeIdx = 0;
    int monthlyDay = 1;
    int weeklyWeekday = DateTime.monday;
    DateTime biweeklyAnchor = DateTime.now();
    int yearlyMonth = DateTime.now().month;
    int yearlyDay = DateTime.now().day;
    int semiMonthlyDay1 = 1;
    int semiMonthlyDay2 = 15;
    DateTime startDate = DateTime.now();

    final categories = await db.getAllCategories();

    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('New Recurring Bill'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name'),
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: amtCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Default amount',
                    prefixText: '\$',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories
                      .map((c) => DropdownMenuItem(
                            value: c.name,
                            child: Text(c.name),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => selectedCategory = v),
                ),
                const SizedBox(height: 16),
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
                  'Bills will only generate on or after this date.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: recurrenceTypeIdx,
                  decoration: const InputDecoration(labelText: 'Recurrence'),
                  items: const [
                    DropdownMenuItem(
                        value: 0, child: Text('Monthly (day of month)')),
                    DropdownMenuItem(value: 1, child: Text('Weekly (weekday)')),
                    DropdownMenuItem(
                        value: 2, child: Text('Biweekly (every 2 weeks)')),
                    DropdownMenuItem(
                        value: 3, child: Text('Semi-monthly (1st & 15th)')),
                    DropdownMenuItem(value: 4, child: Text('Yearly')),
                    DropdownMenuItem(
                        value: 5, child: Text('Last day of month')),
                    DropdownMenuItem(
                        value: 6, child: Text('Last business day')),
                  ],
                  onChanged: (v) => setState(() => recurrenceTypeIdx = v ?? 0),
                ),
                const SizedBox(height: 12),

                // Recurrence-specific options
                if (recurrenceTypeIdx == 0) ...[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Day of month (1-31)',
                      hintText: '1',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => monthlyDay = int.tryParse(v) ?? 1,
                  ),
                ],
                if (recurrenceTypeIdx == 1) ...[
                  DropdownButtonFormField<int>(
                    value: weeklyWeekday,
                    decoration: const InputDecoration(labelText: 'Weekday'),
                    items: const [
                      DropdownMenuItem(
                          value: DateTime.monday, child: Text('Monday')),
                      DropdownMenuItem(
                          value: DateTime.tuesday, child: Text('Tuesday')),
                      DropdownMenuItem(
                          value: DateTime.wednesday, child: Text('Wednesday')),
                      DropdownMenuItem(
                          value: DateTime.thursday, child: Text('Thursday')),
                      DropdownMenuItem(
                          value: DateTime.friday, child: Text('Friday')),
                      DropdownMenuItem(
                          value: DateTime.saturday, child: Text('Saturday')),
                      DropdownMenuItem(
                          value: DateTime.sunday, child: Text('Sunday')),
                    ],
                    onChanged: (v) =>
                        setState(() => weeklyWeekday = v ?? DateTime.monday),
                  ),
                ],
                if (recurrenceTypeIdx == 2) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text('Anchor: ${ymd(biweeklyAnchor)}'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000, 1, 1),
                            lastDate: DateTime(2100, 12, 31),
                            initialDate: biweeklyAnchor,
                          );
                          if (picked != null)
                            setState(() => biweeklyAnchor = picked);
                        },
                        child: const Text('Pick'),
                      ),
                    ],
                  ),
                  const Text(
                    'Pick a date when this bill is due. It will repeat every 2 weeks from this date.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
                if (recurrenceTypeIdx == 3) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration:
                              const InputDecoration(labelText: 'First day'),
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              semiMonthlyDay1 = int.tryParse(v) ?? 1,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration:
                              const InputDecoration(labelText: 'Second day'),
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              semiMonthlyDay2 = int.tryParse(v) ?? 15,
                        ),
                      ),
                    ],
                  ),
                ],
                if (recurrenceTypeIdx == 4) ...[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration:
                              const InputDecoration(labelText: 'Month (1-12)'),
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              yearlyMonth = int.tryParse(v) ?? yearlyMonth,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration:
                              const InputDecoration(labelText: 'Day (1-31)'),
                          keyboardType: TextInputType.number,
                          onChanged: (v) =>
                              yearlyDay = int.tryParse(v) ?? yearlyDay,
                        ),
                      ),
                    ],
                  ),
                ],
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

                String rule;
                switch (recurrenceTypeIdx) {
                  case 0:
                    rule = Recurrence.toMonthly(
                        dayOfMonth: monthlyDay.clamp(1, 31));
                    break;
                  case 1:
                    rule = Recurrence.toWeekly(weekday: weeklyWeekday);
                    break;
                  case 2:
                    rule = Recurrence.toBiweekly(anchor: biweeklyAnchor);
                    break;
                  case 3:
                    rule = Recurrence.toSemiMonthly(
                      day1: semiMonthlyDay1.clamp(1, 31),
                      day2: semiMonthlyDay2.clamp(1, 31),
                    );
                    break;
                  case 4:
                    rule = Recurrence.toYearly(
                      month: yearlyMonth.clamp(1, 12),
                      day: yearlyDay.clamp(1, 31),
                    );
                    break;
                  case 5:
                    rule = Recurrence.toLastDay();
                    break;
                  case 6:
                    rule = Recurrence.toLastBusinessDay();
                    break;
                  default:
                    rule = Recurrence.toMonthly(dayOfMonth: 1);
                }

                await db.upsertBillTemplate(
                  name: name,
                  category: selectedCategory,
                  defaultAmountCents: cents,
                  startDate: ymd(startDate),
                  recurrenceRuleJson: rule,
                );

                // Generate instances for current and next month
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

  Future<void> _showEditTemplateDialog(
      BuildContext context, AppDatabase db, BillTemplate template) async {
    final nameCtrl = TextEditingController(text: template.name);
    final amtCtrl = TextEditingController(
        text: centsToInputString(template.defaultAmountCents));
    String? selectedCategory = template.category;
    DateTime startDate = template.startDate != null
        ? parseYmd(template.startDate!)
        : DateTime.now();

    final categories = await db.getAllCategories();

    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Bill Template'),
          content: SingleChildScrollView(
            child: Column(
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
                    labelText: 'Default amount',
                    prefixText: '\$',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories
                      .map((c) => DropdownMenuItem(
                            value: c.name,
                            child: Text(c.name),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => selectedCategory = v),
                ),
                const SizedBox(height: 16),
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
                  'Note: Changing the recurrence rule requires creating a new template.',
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

                await db.upsertBillTemplate(
                  id: template.id,
                  name: name,
                  category: selectedCategory,
                  defaultAmountCents: cents,
                  startDate: ymd(startDate),
                  recurrenceRuleJson: template.recurrenceRule,
                  active: template.active,
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

  void _showInstanceActions(
      BuildContext context, AppDatabase db, BillInstance b) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(b.titleSnapshot,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${b.dueDate} - ${b.category ?? 'Uncategorized'}'),
              trailing: Text(formatCents(b.amountCents)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Mark paid'),
              onTap: () async {
                Navigator.pop(context);
                await db.markBillPaid(
                    instanceId: b.id, paidAmountCents: b.amountCents);
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.blue),
              title: const Text('Mark unpaid'),
              onTap: () async {
                Navigator.pop(context);
                await db.markBillUnpaid(instanceId: b.id);
              },
            ),
            ListTile(
              leading: Icon(
                b.status == 'skipped' ? Icons.undo : Icons.remove_circle,
                color: Colors.orange,
              ),
              title: Text(b.status == 'skipped' ? 'Unskip' : 'Skip'),
              onTap: () async {
                Navigator.pop(context);
                if (b.status == 'skipped') {
                  await db.unskipBillInstance(instanceId: b.id);
                } else {
                  await db.skipBillInstance(instanceId: b.id);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete instance'),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete bill instance'),
                    content:
                        Text('Delete "${b.titleSnapshot}" due ${b.dueDate}?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel')),
                      FilledButton(
                        style:
                            FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await db.deleteBillInstance(b.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Color _statusColor(BuildContext context, String status) {
  switch (status) {
    case 'paid':
      return Colors.green;
    case 'partial':
      return Colors.orange;
    case 'skipped':
      return Colors.grey;
    default:
      return Theme.of(context).colorScheme.primary;
  }
}
