
import 'package:app_creditos/src/features/quejas-solicitudes/service/flie_tiket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';

class ChatFileBubble extends StatelessWidget {
  final TicketFileModel file;

  const ChatFileBubble({super.key, required this.file});

// aqui se con sume la segunda apai para poder descargalo o visualizar en el momento
// en que el usuario lo desea ver odescargar para soloenes emoento sonsumir el base 64
Future<void> _abrirArchivo(BuildContext context) async {
  final scaffold = ScaffoldMessenger.of(context);

  try {
    print('[📂] Descargando archivo: ${file.filename} (ID: ${file.id})');
    final archivo = await TicketFileService.downloadAndSaveFile(file.id, file.filename);
    print('[📁] Archivo guardado en: ${archivo.path}');

    final result = await OpenFile.open(archivo.path);
    print('[📤] Resultado de abrir archivo: ${result.type}');

    if (result.type != ResultType.done) {
      scaffold.showSnackBar(
        SnackBar(content: Text('⚠️ No se pudo abrir: ${result.message}')),
      );
    }
  } catch (e, stack) {
    print('[❌] Error al abrir archivo: $e');
    print('[📛] Stacktrace: $stack');
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

    final bgColor = isDark ? const Color(0xFF2B2B2B) : Colors.white;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _abrirArchivo(context),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: color.withOpacity(0.35), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: color, size: 22.sp),
              ),
              SizedBox(width: 12.w),
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
                    SizedBox(height: 3.h),
                    Text(
                      ext.toUpperCase(),
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Tooltip(
                message: 'Abrir archivo',
                child: IconButton(
                  icon: const Icon(Icons.open_in_new_rounded),
                  color: color,
                  onPressed: () => _abrirArchivo(context),
                ),
              ),
            ],
          ),
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
