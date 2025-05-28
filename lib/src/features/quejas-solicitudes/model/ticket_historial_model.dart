class TicketHistorialModel {
  final int ticketId;
  final String subject;
  final String ticketType;
  final String lenderName;
  final String status;
  final DateTime creationDate;

  TicketHistorialModel({
    required this.ticketId,
    required this.subject,
    required this.ticketType,
    required this.lenderName,
    required this.status,
    required this.creationDate,
  });

  factory TicketHistorialModel.fromJson(Map<String, dynamic> json) {
    return TicketHistorialModel(
      ticketId: json['ticketId'] as int,
      subject: json['subject'] ?? '',
      ticketType: json['ticketType'] ?? '',
      lenderName: json['lenderName'] ?? '',
      status: json['status'] ?? '',
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}
