import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import '../features/month_generator.dart';

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final db = await AppDatabase.open();
  
  // Generate instances for current and next month on startup
  final generator = MonthGenerator(db);
  await generator.ensureCurrentAndNextMonthGenerated();
  
  ref.onDispose(() => db.close());
  return db;
});

final monthGeneratorProvider = Provider<MonthGenerator?>((ref) {
  final dbAsync = ref.watch(appDatabaseProvider);
  return dbAsync.whenOrNull(data: (db) => MonthGenerator(db));
});
