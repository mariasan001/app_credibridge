import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

/// Servicio encargado de validar el token enviado por correo
/// y asignar una contraseña (temporal o definitiva) para el usuario.
class TokenService {
  /// Envía el código recibido por correo y una contraseña al backend
  /// para validarlo o actualizar la contraseña del usuario.
  ///
  /// Este método se utiliza tanto en la etapa de validación (con contraseña temporal),
  /// como en la creación de una contraseña definitiva.
  ///
  /// Throws:
  /// - String con mensaje personalizado si el backend responde con error.
  /// - 'Error inesperado' si algo falla fuera del control del servicio.
  static Future<void> verificarToken({
    required String code,           // Código enviado al correo
    required String newPassword,    // Contraseña a registrar (temporal o definitiva)
  }) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/reset-password',
        data: {
          'code': code,
          'newPassword': newPassword,
        },
      );

      // Aunque algunos backends retornan 204, validamos ambos como éxito
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw 'Código inválido o expirado.';
      }

    } on DioException catch (e) {
      // Si el backend responde con error, lo extraemos
      final mensaje =
          e.response?.data['message'] ?? 'Error al verificar el token';
      throw mensaje;

    } catch (_) {
      // Si ocurre un error inesperado no controlado
      throw 'Error inesperado al validar el token.';
    }
  }
}
