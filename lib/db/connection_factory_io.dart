import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

Future<QueryExecutor> createExecutor() async {
  return driftDatabase(
    name: 'budget_calendar.db',
    native: const DriftNativeOptions(),
  );
}
