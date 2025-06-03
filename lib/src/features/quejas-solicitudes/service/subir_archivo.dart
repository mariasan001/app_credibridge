// aqui sera el servcio para cargar achivos en el chat 
// entre usarios sin inportar el tipo de usuario 

//importacion de librerias 
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';


class TicketFileService1 {
  static Future<String> subirArchivo(int ticketId, File archivo) async {
    final fileName = archivo.path.split('/').last;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        archivo.path,
        filename: fileName,
      ),
    });

    final response = await ApiService.dio.post(
      '/api/tickets/$ticketId/files',
      data: formData,
    );

    return response.data.toString(); // "Archivo subido correctamente"
  }
}