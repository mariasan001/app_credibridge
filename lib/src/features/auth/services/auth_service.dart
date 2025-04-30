import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _storage = const FlutterSecureStorage();

  // Método para hacer login
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
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['message'] ?? 'Ocurrió un error al iniciar sesión';

      // Imprime el error completo en consola
      print('❌ Error DioException:');
      print('🔸 Status code: $statusCode');
      print('🔸 Mensaje del backend: $message');

      // También podrías devolver un objeto de error si lo deseas
      return Future.error(message); // 👈 esto te deja usarlo en el formulario
    } catch (e) {
      print('⚠️ Error general: $e');
      return Future.error('Error inesperado al iniciar sesión');
    }
  }

  // Método para obtener el perfil autenticado
  static Future<User?> getProfile() async {
    try {
      final response = await ApiService.dio.get('/auth/profile');
      print('✅ Perfil obtenido: ${response.data}');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ Error al obtener perfil: ${e.response?.statusCode}');
      print('🔸 Data: ${e.response?.data}');
      return null;
    } catch (e) {
      print('⚠️ Error general al obtener perfil: $e');
      return null;
    }
  }
}
