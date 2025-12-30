import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDbKey {
  static const _storage = FlutterSecureStorage();
  static const _keyName = 'db_encryption_key_v1';

  static Future<String> getOrCreate() async {
    final existing = await _storage.read(key: _keyName);
    if (existing != null && existing.isNotEmpty) return existing;

    final bytes = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    final key = base64UrlEncode(bytes);

    await _storage.write(key: _keyName, value: key);
    return key;
  }

  static Future<void> deleteKey() async {
    await _storage.delete(key: _keyName);
  }
}
