
import 'package:app_creditos/src/features/quejas-solicitudes/model/lender_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class LenderService {
  static Future<List<LenderModel>> getLendersByUser(String userId) async {
    try {
      final response = await ApiService.dio.get('/api/lenders/by-user/$userId');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => LenderModel.fromJson(e)).toList();
      } else {
        throw Exception('Error al obtener las financieras');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }
}
