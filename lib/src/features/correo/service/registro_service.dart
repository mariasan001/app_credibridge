import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class CorreoService {
  /// Envía el token de verificación al correo del usuario
  static Future<void> enviarTokenPorCorreo({
    required String userId,
    required String email,
  }) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/register',
        data: {
          'userId': userId,
          'email': email,
        },
      );

    if (response.statusCode != 200 && response.statusCode != 204) {

        throw 'Ocurrió un error al enviar el token';
      }
    } on DioException catch (e) {
      final mensaje = e.response?.data['message'] ?? 'Error al enviar el token';
      throw mensaje;
    } catch (_) {
      throw 'Error inesperado. Intenta de nuevo.';
    }
  }
}
