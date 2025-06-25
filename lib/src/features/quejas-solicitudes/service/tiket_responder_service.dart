// service/ticket_response_service.dart
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_responde_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class TicketResponseService {
  static Future<void> sendResponse(TicketResponseModel data) async {
    try {
      final response = await ApiService.dio.post(
        '/api/tickets/respond',
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        print('✅ Respuesta enviada correctamente');
      } else {
        print('⚠️ Falló con código: ${response.statusCode}');
        throw Exception('Error al enviar respuesta');
      }
    } catch (e) {
      print('❌ Error al enviar respuesta: $e');
      rethrow;
    }
  }
}
/**
 * 
 */