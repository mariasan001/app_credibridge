import 'dart:io';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_responde_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/chat_tike_skeleton.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/flie_tiket_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/resposne_finaciera.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/subir_archivo.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/tiket_responder_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/chat_header_widget.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/chat_input_footer.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/chat_message_list.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTicketPage extends StatefulWidget {
  final int ticketId;
  final User user;

  const ChatTicketPage({super.key, required this.ticketId, required this.user});

  @override
  State<ChatTicketPage> createState() => _ChatTicketPageState();
}

class _ChatTicketPageState extends State<ChatTicketPage> {
  final TextEditingController _mensajeController = TextEditingController();
  TicketDetailModel? _ticketDetail;
  List<TicketFileModel> _archivos = [];
  bool _isLoading = true;
  bool _isSending = false;

  File? _archivoSeleccionado;
  String? _archivoNombre;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        TicketService.getTicketDetail(widget.ticketId),
        TicketFileService.getMetadataFiles(widget.ticketId),
      ]);

      if (!mounted) return;

      setState(() {
        _ticketDetail = results[0] as TicketDetailModel;
        _archivos = results[1] as List<TicketFileModel>;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error al cargar datos: $e')),
        );
      }
    }
  }

  Future<void> _enviarMensaje() async {
    final mensaje = _mensajeController.text.trim();
    final tieneArchivo = _archivoSeleccionado != null;

    if (mensaje.isEmpty && !tieneArchivo) return;
    if (_ticketDetail == null) return;

    setState(() => _isSending = true);

    try {
      if (mensaje.isNotEmpty) {
        final data = TicketResponseModel(
          ticketId: _ticketDetail!.ticketId,
          senderId: widget.user.userId,
          message: mensaje,
          isInternal: false,
        );
        await TicketResponseService.sendResponse(data);
      }

      if (tieneArchivo) {
        final msg = await TicketFileService1.subirArchivo(
          widget.ticketId,
          _archivoSeleccionado!,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ $msg')),
        );
      }

      _mensajeController.clear();
      _quitarArchivo();
      await _cargarDatos();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error al enviar: $e')),
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  void _seleccionarArchivo() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      setState(() {
        _archivoSeleccionado = File(path);
        _archivoNombre = result.files.single.name;
      });
    }
  }

  void _quitarArchivo() {
    setState(() {
      _archivoSeleccionado = null;
      _archivoNombre = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;

    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _isLoading
            ? const ChatTicketSkeleton()
            : _ticketDetail == null
                ? const Center(child: Text('No se pudo cargar el ticket'))
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                if (theme.brightness == Brightness.light)
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ChatHeader(ticket: _ticketDetail!),
                                SizedBox(height: 16.h),
                                Expanded(
                                  child: ChatMessageList(
                                    messages: _ticketDetail!.messages,
                                    files: _archivos,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ChatInputFooter(
                        controller: _mensajeController,
                        onSend: _enviarMensaje,
                        onAttach: _seleccionarArchivo,
                        nombreArchivo: _archivoNombre,
                        isSending: _isSending,
                        onRemoveFile: _quitarArchivo,
                      ),
                    ],
                  ),
      ),
    );
  }
}
