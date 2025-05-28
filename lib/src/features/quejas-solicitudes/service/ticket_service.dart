import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_create_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_historial_model.dart'; 

class TicketService {
  static Future<String> createTicket(
    TicketCreateModel ticket, {
    String? filePath,
    String? fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'data': jsonEncode(ticket.toMap()),
        if (filePath != null && filePath.isNotEmpty)
          'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await ApiService.dio.post(
        '/api/tickets',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        throw Exception('Error al crear el ticket');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  static Future<List<TicketHistorialModel>> getHistorialByUser() async {
    try {
      final response = await ApiService.dio.get('/api/tickets/user');
      final List<dynamic> data = response.data;

      return data.map((json) => TicketHistorialModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener historial: $e');
    }
  }
}
