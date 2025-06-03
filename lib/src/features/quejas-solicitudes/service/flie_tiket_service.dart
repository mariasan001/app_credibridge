// esta seccion es para la descarga y visualizacions de los archivos 
// quie se quieren descargar

import 'dart:io';

import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class TicketFileService {
  // 1. Obtener lista de archivos sin contenido
  static Future<List<TicketFileModel>> getMetadataFiles(int ticketId) async {
    final response = await ApiService.dio.get('/api/tickets/ticket/$ticketId');
    final List data = response.data;
    return data.map((json) => TicketFileModel.fromJson(json)).toList();
  }
  // 2. Obtener contenido base64 de un archivo por ID
static Future<File> downloadAndSaveFile(int fileId, String fileName) async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$fileName';

    final response = await ApiService.dio.get(
      '/api/tickets/download/$fileId',
      options: Options(responseType: ResponseType.bytes),
    );

    final file = File(path);
    await file.writeAsBytes(response.data);
    return file;
  }

}