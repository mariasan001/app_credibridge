import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContactoLocalStorage {
  static final _storage = FlutterSecureStorage();
  static const _keyEmail = 'contacto_email';
  static const _keyPhone = 'contacto_phone';

  static Future<void> guardar(String email, String phone) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPhone, value: phone);
  }

  static Future<Map<String, String?>> obtener() async {
    final email = await _storage.read(key: _keyEmail);
    final phone = await _storage.read(key: _keyPhone);
    return {'email': email, 'phone': phone};
  }

  static Future<void> borrar() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyPhone);
  }
}
