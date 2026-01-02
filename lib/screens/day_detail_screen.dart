import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/db_providers.dart';
import '../db/app_database.dart';
import '../utils/date_utils.dart';
import '../utils/money.dart';

class DayDetailScreen extends ConsumerWidget {
  final DateTime date;
  const DayDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(appDatabaseProvider);
    final dateStr = ymd(date);

    return dbAsync.when(
      data: (db) => Scaffold(
        appBar: AppBar(
          title: Text(formatDateLong(date)),
        ),
        body: StreamBuilder(
          stream: db.watchBillInstancesForMonth(dateStr, dateStr),
          builder: (context, snap) {
            final allRows = snap.data ?? [];
            final rows = allRows.where((r) => r.status != 'skipped').toList();
            final skippedRows = allRows.where((r) => r.status == 'skipped').toList();

            if (allRows.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_available, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    const Text('No bills scheduled for this day.'),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () => _showAddBillDialog(context, db, dateStr),
                      icon: const Icon(Icons.add),
                      label: const Text('Add a bill'),
                    ),
                  ],
                ),
              );
            }

            final total = rows.fold<int>(0, (a, b) => a + b.amountCents);
            final paidTotal = rows
                .where((r) => r.status == 'paid' || r.status == 'partial')
                .fold<int>(0, (a, b) => a + (b.paidAmountCents ?? b.amountCents));

            return ListView(
              padding: const EdgeInsets.all(12),
              children: [
                // Summary card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem('Total Due', formatCents(total), Colors.orange),
                        _buildSummaryItem('Paid', formatCents(paidTotal), Colors.green),
                        _buildSummaryItem('Remaining', formatCents(total - paidTotal), Colors.red),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Active bills
                if (rows.isNotEmpty) ...[
                  Text(
                    'Bills Due',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...rows.map((r) => _buildBillCard(context, db, r)),
                ],
                
                // Skipped bills
                if (skippedRows.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Skipped',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...skippedRows.map((r) => _buildBillCard(context, db, r, isSkipped: true)),
                ],
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddBillDialog(context, db, dateStr),
          icon: const Icon(Icons.add),
          label: const Text('Add bill'),
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildBillCard(BuildContext context, AppDatabase db, BillInstance bill, {bool isSkipped = false}) {
    final isPaid = bill.status == 'paid';
    final isPartial = bill.status == 'partial';

    return Card(
      color: isSkipped ? Colors.grey[100] : null,
      child: InkWell(
        onTap: () => _showBillActions(context, db, bill),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Status indicator
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSkipped
                      ? Colors.grey[300]
                      : isPaid
                          ? Colors.green
                          : isPartial
                              ? Colors.orange
                              : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSkipped
                      ? Icons.skip_next
                      : isPaid
                          ? Icons.check
                          : isPartial
                              ? Icons.hourglass_bottom
                              : Icons.receipt_long,
                  color: isSkipped || (!isPaid && !isPartial) ? Colors.grey[600] : Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              // Bill info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.titleSnapshot,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: isSkipped ? TextDecoration.lineThrough : null,
                        color: isSkipped ? Colors.grey : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (bill.category != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              bill.category!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          isPaid
                              ? 'Paid'
                              : isPartial
                                  ? 'Partial'
                                  : isSkipped
                                      ? 'Skipped'
                                      : 'Scheduled',
                          style: TextStyle(
                            fontSize: 12,
                            color: isPaid
                                ? Colors.green
                                : isPartial
                                    ? Colors.orange
                                    : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    if (bill.notes != null && bill.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        bill.notes!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatCents(bill.amountCents),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSkipped ? Colors.grey : null,
                      decoration: isSkipped ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (isPartial && bill.paidAmountCents != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Paid: ${formatCents(bill.paidAmountCents!)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBillActions(BuildContext context, AppDatabase db, BillInstance bill) {
    final isPaid = bill.status == 'paid';
    final isSkipped = bill.status == 'skipped';

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                bill.titleSnapshot,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(formatCents(bill.amountCents)),
            ),
            const Divider(),
            if (!isPaid && !isSkipped)
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Mark as Paid'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.markBillPaid(
                    instanceId: bill.id,
                    paidAmountCents: bill.amountCents,
                  );
                },
              ),
            if (!isPaid && !isSkipped)
              ListTile(
                leading: const Icon(Icons.hourglass_bottom, color: Colors.orange),
                title: const Text('Mark as Partial Payment'),
                onTap: () {
                  Navigator.pop(context);
                  _showPartialPaymentDialog(context, db, bill);
                },
              ),
            if (isPaid)
              ListTile(
                leading: const Icon(Icons.undo, color: Colors.blue),
                title: const Text('Mark as Unpaid'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.markBillUnpaid(instanceId: bill.id);
                },
              ),
            if (!isSkipped)
              ListTile(
                leading: const Icon(Icons.skip_next, color: Colors.grey),
                title: const Text('Skip this occurrence'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.skipBillInstance(instanceId: bill.id);
                },
              ),
            if (isSkipped)
              ListTile(
                leading: const Icon(Icons.restore, color: Colors.blue),
                title: const Text('Restore (unskip)'),
                onTap: () async {
                  Navigator.pop(context);
                  await db.unskipBillInstance(instanceId: bill.id);
                },
              ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit Amount'),
              onTap: () {
                Navigator.pop(context);
                _showEditAmountDialog(context, db, bill);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add, color: Colors.purple),
              title: const Text('Add/Edit Notes'),
              onTap: () {
                Navigator.pop(context);
                _showEditNotesDialog(context, db, bill);
              },
            ),
            if (bill.templateId == null) // Only allow deleting one-time bills
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete'),
                onTap: () async {
                  Navigator.pop(context);
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Bill'),
                      content: const Text('Are you sure you want to delete this bill?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await db.deleteBillInstance(bill.id);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showPartialPaymentDialog(BuildContext context, AppDatabase db, BillInstance bill) {
    final controller = TextEditingController(
      text: centsToInputString(bill.paidAmountCents ?? 0),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Partial Payment'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Amount paid',
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
                await db.markBillPartialPaid(
                  instanceId: bill.id,
                  paidAmountCents: cents,
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

  void _showEditAmountDialog(BuildContext context, AppDatabase db, BillInstance bill) {
    final controller = TextEditingController(
      text: centsToInputString(bill.amountCents),
    );

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
                await db.updateBillInstanceAmount(
                  instanceId: bill.id,
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

  void _showEditNotesDialog(BuildContext context, AppDatabase db, BillInstance bill) {
    final controller = TextEditingController(text: bill.notes ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notes'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Add any notes about this bill...',
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await db.updateBillInstanceNotes(
                instanceId: bill.id,
                notes: controller.text.isEmpty ? null : controller.text,
              );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddBillDialog(BuildContext context, AppDatabase db, String dateStr) async {
    final nameCtrl = TextEditingController();
    final amtCtrl = TextEditingController();
    String? selectedCategory;

    final categories = await db.getAllCategories();

    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add one-time bill'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    labelText: 'Amount',
                    prefixText: '\$',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categories.map((c) => DropdownMenuItem(
                    value: c.name,
                    child: Text(c.name),
                  )).toList(),
                  onChanged: (v) => setState(() => selectedCategory = v),
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

                await db.addOneTimeBillInstance(
                  title: name,
                  amountCents: cents,
                  dueDate: dateStr,
                  category: selectedCategory,
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
}
