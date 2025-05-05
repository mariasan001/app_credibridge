import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class TokenService {
  /// Verifica el código recibido por correo y establece una contraseña temporal
  static Future<void> verificarToken({
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/reset-password',
        data: {'code': code, 'newPassword': newPassword},
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw 'Código inválido o expirado.';
      }
    } on DioException catch (e) {
      final mensaje =
          e.response?.data['message'] ?? 'Error al verificar el token';
      throw mensaje;
    } catch (_) {
      throw 'Error inesperado al validar el token.';
    }
  }
}
