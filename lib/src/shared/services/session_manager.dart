import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_token';

  // Guardar el token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Obtener el token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // ✅ Eliminar el token (cerrar sesión)
  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // (opcional) Limpiar todo el storage
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
