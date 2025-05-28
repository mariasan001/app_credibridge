class TicketMessage {
  final String senderName;
  final String content;
  final bool isInternal;
  final DateTime sendDate;
  final List<String> roles;

  TicketMessage({
    required this.senderName,
    required this.content,
    required this.isInternal,
    required this.sendDate,
    required this.roles,
  });

  factory TicketMessage.fromJson(Map<String, dynamic> json) {
    return TicketMessage(
      senderName: json['senderName'] ?? '',
      content: json['content'] ?? '',
      isInternal: json['isInternal'] ?? false,
      sendDate: DateTime.parse(json['sendDate']),
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}

class TicketDetailModel {
  final int ticketId;
  final String subject;
  final String description;
  final String ticketType;
  final String status;
  final String lenderName;
  final String? clarificationType;
  final String? assignedTo;
  final String user;
  final DateTime creationDate;
  final DateTime? lastResponse;
  final List<TicketMessage> messages;

  TicketDetailModel({
    required this.ticketId,
    required this.subject,
    required this.description,
    required this.ticketType,
    required this.status,
    required this.lenderName,
    this.clarificationType,
    this.assignedTo,
    required this.user,
    required this.creationDate,
    this.lastResponse,
    required this.messages,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    return TicketDetailModel(
      ticketId: json['ticketId'],
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      ticketType: json['ticketType'] ?? '',
      status: json['status'] ?? '',
      lenderName: json['lenderName'] ?? '',
      clarificationType: json['clarificationType'],
      assignedTo: json['assignedTo'],
      user: json['user'] ?? '',
      creationDate: DateTime.parse(json['creationDate']),
      lastResponse: json['lastResponse'] != null
          ? DateTime.parse(json['lastResponse'])
          : null,
      messages: (json['messages'] as List<dynamic>)
          .map((m) => TicketMessage.fromJson(m))
          .toList(),
    );
  }
}
