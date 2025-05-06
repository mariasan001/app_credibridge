import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

/// Servicio que gestiona el envío del token para recuperar la contraseña.
class RecuperarCorreoService {
  /// Envía el token de recuperación al correo especificado.
  static Future<void> enviarTokenRecuperacion({required String email}) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/forgot-password', // Endpoint 
        data: {'email': email},   // Solo se necesita el correo
      );

      // Validamos el código de estado para confirmar que fue exitoso
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw 'No se pudo enviar el token de recuperación.';
      }
    } on DioException catch (e) {
      // Error personalizado desde el backend
      final mensaje = e.response?.data['message'] ?? 'Error al enviar el token';
      throw mensaje;
    } catch (_) {
      // Error no controlado
      throw 'Ocurrió un error inesperado. Intenta de nuevo.';
    }
  }
}
