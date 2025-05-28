class TicketCreateModel {
  final String userId;
  final String subject;
  final String description;
  final int ticketTypeId;
  final int lenderId;
  final int? clarificationType;
  final String initialMessage;

  TicketCreateModel({
    required this.userId,
    required this.subject,
    required this.description,
    required this.ticketTypeId,
    required this.lenderId,
    required this.clarificationType,
    required this.initialMessage,
  });

  // 🔁 Este sí lo necesitas para serializar como string
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'subject': subject,
      'description': description,
      'ticketTypeId': ticketTypeId,
      'lenderId': lenderId,
      'clarification_type': clarificationType,
      'initialMessage': initialMessage,
    };
  }
}
