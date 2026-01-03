import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import '../features/month_generator.dart';

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final db = await AppDatabase.open();

  // Generate instances for current and next month on startup (native/desktop/mobile only)
  if (!db.isWeb) {
    final generator = MonthGenerator(db);
    await generator.ensureCurrentAndNextMonthGenerated();
  }

  ref.onDispose(() => db.close());
  return db;
});

final monthGeneratorProvider = Provider<MonthGenerator?>((ref) {
  final dbAsync = ref.watch(appDatabaseProvider);
  return dbAsync.whenOrNull(data: (db) => MonthGenerator(db));
});

final syncSettingsProvider = StreamProvider<SyncSetting?>((ref) {
  final dbAsync = ref.watch(appDatabaseProvider);
  return dbAsync.when(
    data: (db) => db.watchSyncSettings(),
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});
