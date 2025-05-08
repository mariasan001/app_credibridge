import 'package:app_creditos/src/features/inicio/model/descuento_response.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:dio/dio.dart';

class DescuentoService {
static Future<DescuentoResponse> obtenerDescuento(String userId) async {
  try {
    print('📡 GET /users/$userId/discount-limit');
    final response = await ApiService.dio.get('/users/$userId/discount-limit');

    print('🔽 Body de respuesta: ${response.data}');

    // Si viene un número directo (como 2293.41), lo usamos
    if (response.data is num) {
      return DescuentoResponse(amount: (response.data as num).toDouble());
    }

    // Si viene un JSON tipo {"amount": 1000}
    if (response.data is Map<String, dynamic>) {
      return DescuentoResponse.fromJson(response.data);
    }

    throw 'Respuesta inesperada del servidor: ${response.data}';
  } catch (e) {
    print('❗ Error desconocido: $e');
    rethrow;
  }
}



}
