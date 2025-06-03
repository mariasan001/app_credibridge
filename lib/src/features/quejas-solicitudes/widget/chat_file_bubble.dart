import 'dart:convert';
import 'dart:io';

import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ChatFileBubble extends StatelessWidget {
  final TicketFileModel file;

  const ChatFileBubble({super.key, required this.file});

  Future<void> _descargarYMostrar(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    try {
      final bytes = base64Decode(file.base64Content);
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/${file.filename}';
      final archivo = File(path);
      await archivo.writeAsBytes(bytes);

      final result = await OpenFile.open(path);
      if (result.type != ResultType.done) {
        scaffold.showSnackBar(
          SnackBar(content: Text('⚠️ No se pudo abrir: ${result.message}')),
        );
      }
    } catch (e) {
      scaffold.showSnackBar(
        SnackBar(content: Text('❌ Error al abrir archivo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ext = _getExtension(file.filename);
    final icon = _getIconByExtension(ext);
    final color = _getColorByExtension(ext);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2B2B2B) : const Color.fromARGB(255, 255, 255, 255);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            // Ícono del archivo
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 12.w),

            // Info del archivo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.filename.isNotEmpty ? file.filename : 'Archivo sin nombre',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    ext.toUpperCase(),
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // Botón de abrir
            TextButton(
              onPressed: () => _descargarYMostrar(context),
              child: Text("Abrir", style: TextStyle(fontSize: 12.sp, color: color)),
            ),
          ],
        ),
      ),
    );
  }

  String _getExtension(String filename) {
    final parts = filename.split('.');
    return parts.length > 1 ? parts.last.toLowerCase().trim() : 'archivo';
  }

  IconData _getIconByExtension(String ext) {
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

// estos son los colroes de fondo dependiendo el tipo de 
  Color _getColorByExtension(String ext) {
    switch (ext) {
      case 'pdf':
        return Colors.redAccent;
      case 'doc':
      case 'docx':
        return Colors.blueAccent;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Colors.orange;
      case 'txt':
        return Colors.grey;
      default:
        return Colors.indigo;
    }
  }
}
