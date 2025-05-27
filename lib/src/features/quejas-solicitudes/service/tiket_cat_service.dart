import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_cat.model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class ClarificationTypeService {
  static Future<List<ClarificationTypeModel>> getAllClarificationTypes() async {
    try {
      final response = await ApiService.dio.get('/api/clarification-types');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => ClarificationTypeModel.fromJson(e)).toList();
      } else {
        throw Exception('Error al obtener los tipos de aclaración');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
