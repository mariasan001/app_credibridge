// ignore_for_file: avoid_print
import 'package:app_creditos/src/features/inicio/model/descuento_response.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class DescuentoService {
  static Future<DescuentoResponse> obtenerDescuento(String userId) async {
    try {
      print(' GET /users/$userId/discount-limit');
      
      final response = await ApiService.dio.get('/users/$userId/discount-limit');
      print(' Status: ${response.statusCode}');
      print('Body de respuesta: ${response.data}');

      final data = response.data;

      if (data is num) {
        return DescuentoResponse(amount: data.toDouble());
      }

      if (data is Map<String, dynamic>) {
        return DescuentoResponse.fromJson(data);
      }

      throw 'Respuesta inesperada del servidor: $data';
    } catch (e) {
      print('❗ Error desconocido: $e');
      rethrow;
    }
  }
}
