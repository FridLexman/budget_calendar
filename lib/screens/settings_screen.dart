import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../state/db_providers.dart';
import '../db/app_database.dart';
import '../features/sync_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _baseUrlCtrl = TextEditingController();
  final _apiKeyCtrl = TextEditingController();
  bool _useRemote = false;
  String _mode = 'local_only';
  bool _hydratedOnce = false;

  @override
  void dispose() {
    _baseUrlCtrl.dispose();
    _apiKeyCtrl.dispose();
    super.dispose();
  }

  void _hydrate(SyncSetting s) {
    _useRemote = s.useRemote;
    _mode = s.mode;
    _baseUrlCtrl.text = s.baseUrl ?? '';
    _apiKeyCtrl.text = s.apiKey ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(syncSettingsProvider);

    return settingsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error loading settings: $e')),
      ),
      data: (settings) {
        if (!_hydratedOnce && settings != null) {
          _hydrate(settings);
          _hydratedOnce = true;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const Text(
                  'Data source',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Use remote MySQL via API'),
                  subtitle: const Text('Enable cloud sync; SQLite stays as local cache'),
                  value: _useRemote,
                  onChanged: (v) => setState(() => _useRemote = v),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _mode,
                  decoration: const InputDecoration(labelText: 'Sync mode'),
                  items: const [
                    DropdownMenuItem(value: 'local_only', child: Text('Local only')),
                    DropdownMenuItem(value: 'hybrid', child: Text('Hybrid (local + remote)')),
                  ],
                  onChanged: (v) => setState(() => _mode = v ?? 'local_only'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _baseUrlCtrl,
                  decoration: const InputDecoration(
                    labelText: 'API Base URL',
                    hintText: 'https://your-server.example.com',
                  ),
                  keyboardType: TextInputType.url,
                  enabled: _useRemote,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _apiKeyCtrl,
                  decoration: InputDecoration(
                    labelText: 'API Key',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.qr_code_scanner),
                          tooltip: 'Scan QR',
                          onPressed: _useRemote ? _scanQrForKey : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          tooltip: 'Clear',
                          onPressed: _useRemote
                              ? () => setState(() => _apiKeyCtrl.clear())
                              : null,
                        ),
                      ],
                    ),
                  ),
                  obscureText: true,
                  enabled: _useRemote,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: _useRemote ? _testConnection : null,
                        child: const Text('Test connection'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _useRemote ? _syncNow : null,
                        child: const Text('Sync now'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.history, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Last sync: ${settings?.lastSyncServerMs ?? 0}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonal(
                        onPressed: () => _save(settings),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Notes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Remote sync expects a self-hosted API that talks to MySQL. '
                  'Provide a base URL and API key (QR supported). SQLite remains active for offline use.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _scanQrForKey() async {
    final code = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const _QrScanPage()),
    );
    if (code != null && mounted) {
      setState(() {
        _apiKeyCtrl.text = code;
      });
    }
  }

  Future<void> _save(SyncSetting? existing) async {
    final dbAsync = ref.read(appDatabaseProvider);
    final db = dbAsync.requireValue;
    await db.saveSyncSettings(
      useRemote: _useRemote,
      mode: _mode,
      baseUrl: _useRemote ? _baseUrlCtrl.text.trim() : null,
      apiKey: _useRemote ? _apiKeyCtrl.text.trim() : null,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
  }

  Future<void> _testConnection() async {
    final settings = SyncSetting(
      id: 0,
      useRemote: _useRemote,
      baseUrl: _baseUrlCtrl.text.trim(),
      apiKey: _apiKeyCtrl.text.trim(),
      mode: _mode,
      updatedAt: DateTime.now(),
      lastSyncServerMs: 0,
      deviceId: null,
    );
    final dbAsync = ref.read(appDatabaseProvider);
    final db = dbAsync.requireValue;
    final service = SyncService(db, settings);
    final result = await service.testConnection();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.message),
        backgroundColor: result.ok ? Colors.green : Colors.orange,
      ),
    );
  }

  Future<void> _syncNow() async {
    final settings = SyncSetting(
      id: 0,
      useRemote: _useRemote,
      baseUrl: _baseUrlCtrl.text.trim(),
      apiKey: _apiKeyCtrl.text.trim(),
      mode: _mode,
      updatedAt: DateTime.now(),
      lastSyncServerMs: 0,
      deviceId: null,
    );
    final dbAsync = ref.read(appDatabaseProvider);
    final db = dbAsync.requireValue;
    final service = SyncService(db, settings);
    final result = await service.syncNow();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.message),
        backgroundColor: result.ok ? Colors.green : Colors.orange,
      ),
    );
  }
}

class _QrScanPage extends StatefulWidget {
  const _QrScanPage();

  @override
  State<_QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<_QrScanPage> {
  bool _handled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan API Key')),
      body: MobileScanner(
        onDetect: (capture) {
          if (_handled) return;
          final barcodes = capture.barcodes;
          if (barcodes.isEmpty) return;
          final code = barcodes.first.rawValue;
          if (code == null || code.isEmpty) return;
          _handled = true;
          Navigator.of(context).pop(code);
        },
      ),
    );
  }
}
