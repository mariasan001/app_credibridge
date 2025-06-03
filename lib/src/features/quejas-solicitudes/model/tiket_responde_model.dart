class TicketResponseModel {
  final int ticketId;
  final String senderId;
  final String message;
  final bool isInternal;

  TicketResponseModel({
    required this.ticketId,
    required this.senderId,
    required this.message,
    required this.isInternal,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'senderId': senderId,
      'message': message,
      'isInternal': isInternal,
    };
  }
}
