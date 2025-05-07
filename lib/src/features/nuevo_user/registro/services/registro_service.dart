import 'package:app_creditos/src/features/nuevo_user/registro/model/servidor_publico_request.dart';
import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class RegistroService {
  static Future<bool> validarServidor(ServidorPublicoRequest data) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/register/validate',
        data: data.toJson(),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      final mensaje = e.response?.data['message'] ?? 'Datos no válidos o usuario ya registrado';
      throw mensaje;
    } catch (_) {
      throw 'Error inesperado. Intenta de nuevo.';
    }
  }
}
