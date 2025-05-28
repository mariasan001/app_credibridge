import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/service/resposne_finaciera.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarDetalle();
  }

  String capitalizarNombre(String nombre) {
    return nombre
        .toLowerCase()
        .split(' ')
        .map(
          (palabra) =>
              palabra.isNotEmpty
                  ? '${palabra[0].toUpperCase()}${palabra.substring(1)}'
                  : '',
        )
        .join(' ');
  }

  Future<void> _cargarDetalle() async {
    try {
      final detalle = await TicketService.getTicketDetail(widget.ticketId);
      setState(() {
        _ticketDetail = detalle;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error al cargar ticket: $e');
      setState(() => _isLoading = false);
    }
  }

  void _seleccionarArchivo() async {}

  void _enviarMensaje() {
    print("Mensaje enviado: ${_mensajeController.text}");
    _mensajeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bubbleUser =
        isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF9F9F9);
    final bubbleGestor =
        isDark ? const Color(0xFF3A3A3A) : const Color(0xFFFFF7E0);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      backgroundColor: scaffoldColor,
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _ticketDetail == null
              ? const Center(child: Text('No se pudo cargar el ticket'))
              : _buildChatView(cardColor, bubbleUser, bubbleGestor, textColor),
    );
  }

  Widget _buildChatView(
    Color cardColor,
    Color bubbleUser,
    Color bubbleGestor,
    Color textColor,
  ) {
    final t = _ticketDetail!;
    final isQueja = t.ticketType.toLowerCase().contains('queja');
    final tipoColor = isQueja ? Colors.red : Colors.blue;

    final primerMensajeUsuarioIndex = t.messages.indexWhere(
      (m) => m.roles.contains('USER'),
    );

    return Column(
      children: [
        /// HEADER + CHAT
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                if (Theme.of(context).brightness == Brightness.light)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER INFO
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: tipoColor.withOpacity(0.1),
                        child: Icon(
                          isQueja
                              ? Icons.report_problem
                              : Icons.chat_bubble_outline,
                          color: tipoColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.lenderName,
                              style: AppTextStyles.promoBold(
                                context,
                              ).copyWith(fontSize: 14.sp, color: textColor),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 12.sp,
                                  color: Colors.grey.shade500,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  DateFormat(
                                    'dd/MM/yyyy HH:mm',
                                  ).format(t.creationDate),
                                  style: AppTextStyles.bodySmall(
                                    context,
                                  ).copyWith(
                                    fontSize: 11.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: tipoColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          t.ticketType.toUpperCase(),
                          style: AppTextStyles.promoButtonText(
                            context,
                          ).copyWith(
                            fontSize: 10.sp,
                            color: tipoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  /// MENSAJES
                  ...t.messages.asMap().entries.map((entry) {
                    final i = entry.key;
                    final m = entry.value;
                    final esDelUsuario = m.roles.contains('USER');
                    final isFirstUserMessage = i == primerMensajeUsuarioIndex;
                    final bubbleColor =
                        esDelUsuario ? bubbleUser : bubbleGestor;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment:
                            esDelUsuario
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: bubbleColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14.r),
                                  topRight: Radius.circular(14.r),
                                  bottomLeft: Radius.circular(
                                    esDelUsuario ? 14.r : 0,
                                  ),
                                  bottomRight: Radius.circular(
                                    esDelUsuario ? 0 : 14.r,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${capitalizarNombre(m.senderName)} (${m.roles.join(', ')})',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  if (isFirstUserMessage) ...[
                                    Text(
                                      'Asunto: ${t.subject}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: textColor,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Descripción: ${t.description}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: textColor,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                  ],
                                  Text(
                                    m.content,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: textColor,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      DateFormat(
                                        'dd/MM/yyyy HH:mm',
                                      ).format(m.sendDate),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),

        /// FOOTER
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _seleccionarArchivo,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.attach_file,
                    color: Colors.orange,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: _mensajeController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje...",
                    hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 42.h,
                width: 42.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                  onPressed: _enviarMensaje,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
