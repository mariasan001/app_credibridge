import 'package:dio/dio.dart';

import 'package:app_creditos/src/shared/services/api_service.dart';

/// Servicio encargado de enviar el token de verificación al correo del usuario.
/// Se utiliza durante el registro de un nuevo usuario.
class CorreoService {
  /// Envía el token al correo ingresado por el usuario.
  /// 
  /// Parámetros:
  /// - [userId]: ID del servidor público
  /// - [email]: Correo electrónico donde se enviará el token
  ///
  /// Lanza excepciones en caso de error HTTP o fallos inesperados.
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

      // Si el servidor responde con un código diferente a 200 o 204, se considera error
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw 'Ocurrió un error al enviar el token';
      }
    } on DioException catch (e) {
      // Extraemos el mensaje del backend si existe
      final mensaje = e.response?.data['message'] ?? 'Error al enviar el token';
      throw mensaje;
    } catch (_) {
      // Fallback para cualquier otro error inesperado
      throw 'Error inesperado. Intenta de nuevo.';
    }
  }
}
