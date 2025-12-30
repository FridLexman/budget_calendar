import 'package:http/http.dart' as http;
import '../db/app_database.dart';

class SyncTestResult {
  final bool ok;
  final String message;
  const SyncTestResult(this.ok, this.message);
}

class SyncService {
  final SyncSetting settings;
  SyncService(this.settings);

  bool get isRemoteEnabled =>
      settings.useRemote &&
      (settings.baseUrl?.isNotEmpty ?? false) &&
      (settings.apiKey?.isNotEmpty ?? false);

  Uri? _healthUri() {
    if (!isRemoteEnabled) return null;
    try {
      return Uri.parse(settings.baseUrl!).resolve('/health');
    } catch (_) {
      return null;
    }
  }

  Future<SyncTestResult> testConnection() async {
    final uri = _healthUri();
    if (uri == null) {
      return const SyncTestResult(false, 'Remote sync disabled or invalid URL');
    }
    try {
      final resp = await http
          .get(uri, headers: {'x-api-key': settings.apiKey ?? ''})
          .timeout(const Duration(seconds: 8));
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        return const SyncTestResult(true, 'Connection OK');
      }
      return SyncTestResult(false, 'Server responded ${resp.statusCode}');
    } catch (e) {
      return SyncTestResult(false, 'Failed: $e');
    }
  }

  // TODO: Implement fetch/push sync once backend contract is finalized.
  Future<SyncTestResult> placeholderSync() async {
    if (!isRemoteEnabled) {
      return const SyncTestResult(false, 'Remote sync disabled');
    }
    return const SyncTestResult(false, 'Sync not yet implemented');
  }
}
