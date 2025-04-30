import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _storage = const FlutterSecureStorage();

  static Future<LoginResponse?> login(String username, String password) async {
    try {
      final response = await ApiService.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      final data = LoginResponse.fromJson(response.data);
      await _storage.write(key: 'token', value: data.token);
      return data;
    } on DioException catch (e) {
      print(' Error DioException:');
      print(' Status code: ${e.response?.statusCode}');
      print(' Data: ${e.response?.data}');
      return null;
    } catch (e) {
      print(' Error general: $e');
      return null;
    }
  }
}
