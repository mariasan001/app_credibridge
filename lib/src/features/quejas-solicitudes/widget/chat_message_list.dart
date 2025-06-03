import 'package:app_creditos/src/features/quejas-solicitudes/model/file_tiket.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';
import 'chat_message_bubble.dart';
import 'chat_file_bubble.dart';

class ChatMessageList extends StatelessWidget {
  final List<TicketMessage> messages;
  final List<TicketFileModel> files;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.files,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleUser = theme.brightness == Brightness.dark ? const Color(0xFF2A2A2A) : const Color(0xFFF9F9F9);
    final bubbleGestor = theme.brightness == Brightness.dark ? const Color(0xFF3A3A3A) : const Color(0xFFFFF7E0);

    final primerMensajeUsuarioIndex = messages.indexWhere((m) => m.roles.contains('USER'));

    // Mezcla de mensajes y archivos (orden lineal, no por fecha real)
    final items = [...messages, ...files];

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];

        if (item is TicketMessage) {
          final isUser = item.roles.contains('USER');
          final showHeader = i == primerMensajeUsuarioIndex;
          return ChatMessageBubble(
            message: item,
            isUser: isUser,
            showHeader: showHeader,
            bubbleColor: isUser ? bubbleUser : bubbleGestor,
          );
        } else if (item is TicketFileModel) {
          return ChatFileBubble(file: item);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
