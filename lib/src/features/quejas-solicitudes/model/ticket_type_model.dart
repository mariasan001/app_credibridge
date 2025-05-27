class TicketTypeModel {
  final int id;
  final String ticketTypeDesc;

  TicketTypeModel({
    required this.id,
    required this.ticketTypeDesc,
  });

  factory TicketTypeModel.fromJson(Map<String, dynamic> json) {
    return TicketTypeModel(
      id: json['id'],
      ticketTypeDesc: json['ticketTypeDesc'],
    );
  }

  get clarificationTypes => null;
}
