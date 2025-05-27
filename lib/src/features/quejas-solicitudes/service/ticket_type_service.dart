import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_model.dart';

class TicketTypeService {
  static Future<List<TicketTypeModel>> getAllTicketTypes() async {
    try {
      final response = await ApiService.dio.get('/api/ticket-types');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => TicketTypeModel.fromJson(e)).toList();
      } else {
        throw Exception('Error al obtener los tipos de ticket');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
