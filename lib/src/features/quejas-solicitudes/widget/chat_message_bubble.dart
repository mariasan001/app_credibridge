
// chat_message_bubble.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final TicketMessage message;
  final bool isUser;
  final bool showHeader;
  final Color bubbleColor;
  const ChatMessageBubble({super.key, required this.message, required this.isUser, required this.showHeader, required this.bubbleColor});

  String capitalizarNombre(String nombre) {
    return nombre
        .toLowerCase()
        .split(' ')
        .map((p) => p.isNotEmpty ? '${p[0].toUpperCase()}${p.substring(1)}' : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
                bottomLeft: Radius.circular(isUser ? 14.r : 0),
                bottomRight: Radius.circular(isUser ? 0 : 14.r),
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
                if (showHeader)
                  Text(
                    '${capitalizarNombre(message.senderName)} (${message.roles.join(', ')})',
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                  ),
                if (showHeader) SizedBox(height: 6.h),
                Text(message.content, style: TextStyle(fontSize: 13.sp, color: Theme.of(context).textTheme.bodyLarge?.color)),
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(message.sendDate),
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}