import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class TicketService {
  static Future<TicketDetailModel> getTicketDetail(int id) async {
    final response = await ApiService.dio.get('/api/tickets/$id/detail');

    if (response.statusCode == 200) {
      return TicketDetailModel.fromJson(response.data);
    } else {
      throw Exception('Error al obtener detalles del ticket');
    }
  }
}
