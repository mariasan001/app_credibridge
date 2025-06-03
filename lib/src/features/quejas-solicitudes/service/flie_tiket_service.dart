import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class TicketFileService {
  static Future<List<TicketFileModel>> getFiles(int ticketId) async {
    final response = await ApiService.dio.get('/api/tickets/tickets/$ticketId/files');
    final List data = response.data;
    return data.map((json) => TicketFileModel.fromJson(json)).toList();
  }
}