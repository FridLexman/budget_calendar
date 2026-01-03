import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/sync_service.dart';
import '../state/db_providers.dart';
import 'dashboard_screen.dart';
import 'calendar_screen.dart';
import 'bills_screen.dart';
import 'income_screen.dart';
import 'settings_screen.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int idx = 0;
  bool _autoSyncStarted = false;

  final screens = const [
    DashboardScreen(),
    CalendarScreen(),
    BillsScreen(),
    IncomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    _maybeAutoSync();
    return Scaffold(
      body: IndexedStack(
        index: idx,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (v) => setState(() => idx = v),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Bills'),
          NavigationDestination(icon: Icon(Icons.payments), label: 'Income'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: _buildSyncFab(context),
    );
  }

  void _maybeAutoSync() {
    if (_autoSyncStarted) return;
    final settingsAsync = ref.read(syncSettingsProvider);
    final settings = settingsAsync.value;
    if (settings == null ||
        settings.useRemote != true ||
        (settings.baseUrl?.isEmpty ?? true) ||
        (settings.apiKey?.isEmpty ?? true)) {
      return;
    }
    _autoSyncStarted = true;
    Future.microtask(() async {
      final db = await ref.read(appDatabaseProvider.future);
      final svc = SyncService(db, settings);
      final result = await svc.syncNow();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: result.ok ? Colors.green : Colors.orange,
        ),
      );
    });
  }

  Widget? _buildSyncFab(BuildContext context) {
    final isWindows = !kIsWeb && Platform.isWindows;
    if (!isWindows) return null;

    final settingsAsync = ref.watch(syncSettingsProvider);
    final settings = settingsAsync.value;
    if (settings == null || settings.useRemote != true) return null;

    return FloatingActionButton.extended(
      heroTag: 'sync_fab',
      icon: const Icon(Icons.sync),
      label: const Text('Sync now'),
      onPressed: () async {
        final db = await ref.read(appDatabaseProvider.future);
        final svc = SyncService(db, settings);
        final result = await svc.syncNow();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: result.ok ? Colors.green : Colors.orange,
          ),
        );
      },
    );
  }
}
