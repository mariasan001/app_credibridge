// lib/src/shared/services/session_manager.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token); // 🔑 esta clave
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token'); // 👈 debe coincidir
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: 'jwt_token'); // 👈 y aquí también
  }
}
