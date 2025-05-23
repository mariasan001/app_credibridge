// lib/src/shared/services/session_manager.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static final _storage = const FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }
}
