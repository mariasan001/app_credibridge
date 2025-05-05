import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class RegistroService {
  /// Valida si el número de servidor público existe y está habilitado para registrarse
  static Future<bool> validarServidor(String userId) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/register/validate',
        data: {'userId': userId},
      );

      // Si el código de estado es 200, se considera éxito
      return response.statusCode == 200;
    } on DioException catch (e) {
      final mensaje = e.response?.data['message'] ?? 'Servidor no encontrado o ya registrado';
      throw mensaje;
    } catch (_) {
      throw 'Error inesperado. Intenta de nuevo.';
    }
  }
}
