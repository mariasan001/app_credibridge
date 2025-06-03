import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_responde_model.dart';

import 'package:app_creditos/src/features/quejas-solicitudes/service/resposne_finaciera.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/tiket_responder_service.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/flie_tiket_service.dart';

import 'package:app_creditos/src/features/quejas-solicitudes/widget/chat_header_widget.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/chat_input_footer.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/widget/chat_message_list.dart';

import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';

class ChatTicketPage extends StatefulWidget {
  final int ticketId;
  final User user;

  const ChatTicketPage({
    super.key,
    required this.ticketId,
    required this.user,
  });

  @override
  State<ChatTicketPage> createState() => _ChatTicketPageState();
}

class _ChatTicketPageState extends State<ChatTicketPage> {
  final TextEditingController _mensajeController = TextEditingController();
  TicketDetailModel? _ticketDetail;
  List<TicketFileModel> _archivos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarDetalle();
  }

  Future<void> _cargarDetalle() async {
    try {
      print('🔄 Solicitando detalle del ticket...');
      final detalle = await TicketService.getTicketDetail(widget.ticketId);
      print('✅ Ticket cargado: ${detalle.ticketId} con ${detalle.messages.length} mensajes');

      final archivos = await TicketFileService.getFiles(widget.ticketId);
      print('📎 Archivos encontrados: ${archivos.length}');

      setState(() {
        _ticketDetail = detalle;
        _archivos = archivos;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error al cargar detalle o archivos: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _enviarMensaje() async {
    final mensaje = _mensajeController.text.trim();
    if (mensaje.isEmpty || _ticketDetail == null) return;

    try {
      final data = TicketResponseModel(
        ticketId: _ticketDetail!.ticketId,
        senderId: widget.user.userId,
        message: mensaje,
        isInternal: false,
      );

      await TicketResponseService.sendResponse(data);
      _mensajeController.clear();
      await _cargarDetalle();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error al enviar mensaje: $e')),
      );
    }
  }

  void _seleccionarArchivo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📎 Adjuntar archivo aún no implementado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor =
        theme.brightness == Brightness.dark ? const Color(0xFF1E1E1E) : Colors.white;

    print('🎨 build ejecutado, loading: $_isLoading');
    if (_ticketDetail != null) {
      print('🎟️ ticketId: ${_ticketDetail!.ticketId}');
      print('💬 mensajes: ${_ticketDetail!.messages.length}');
      print('📎 archivos: ${_archivos.length}');
    }

    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
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
                    ),
                  ],
                ),
    );
  }
}
