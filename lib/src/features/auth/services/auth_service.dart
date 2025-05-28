// ignore_for_file: avoid_print
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart'; 
import 'package:dio/dio.dart';

class AuthService {
  ///  Login: guarda token desde cookie y devuelve usuario
  static Future<User?> login(String username, String password) async {
    try {
      final response = await ApiService.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      // Extraer token JWT desde cookie
      String? jwtToken;
      try {
        final setCookie = response.headers.map['set-cookie']?.first;
        jwtToken = setCookie
            ?.split(';')
            .firstWhere((e) => e.trim().startsWith('JWT='))
            .split('=')
            .last;
      } catch (_) {
        print(' No se pudo extraer el token JWT de la cookie');
      }

      if (jwtToken != null && jwtToken.isNotEmpty) {
        await SessionManager.saveToken(jwtToken); // ✅ Uso correcto
        print('JWT guardado correctamente');
      }

      final user = User.fromJson(response.data['user']);
      print(' Usuario logueado: ${user.userId}');
      return user;

    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['message'] ?? 'Ocurrió un error al iniciar sesión';
      print(' DioException: $statusCode');
      print('Mensaje: $message');
      return Future.error(message);
    } catch (e) {
      print('Error inesperado: $e');
      return Future.error('Error inesperado al iniciar sesión');
    }
  }

  /// 👤 Obtener perfil autenticado (si tu backend lo soporta)
  static Future<User?> getProfile() async {
    try {
      final response = await ApiService.dio.get('/auth/profile');
      print(' Perfil obtenido: ${response.data}');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      print('Error al obtener perfil: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      return null;
    } catch (e) {
      print(' Error general al obtener perfil: $e');
      return null;
    }
  }
}
