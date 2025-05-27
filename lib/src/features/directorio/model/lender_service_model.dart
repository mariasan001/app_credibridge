
class LenderServiceGrouped {
  final int serviceTypeId;
  final String serviceTypeDesc;
  final List<LenderService> services;

  LenderServiceGrouped({
    required this.serviceTypeId,
    required this.serviceTypeDesc,
    required this.services,
  });

  factory LenderServiceGrouped.fromJson(Map<String, dynamic> json) {
    return LenderServiceGrouped(
      serviceTypeId: json['serviceTypeId'],
      serviceTypeDesc: json['serviceTypeDesc'],
      services: (json['services'] as List)
          .map((s) => LenderService.fromJson(s))
          .toList(),
    );
  }
}

class LenderService {
  final String serviceDesc;
  final Lender lender;

  LenderService({
    required this.serviceDesc,
    required this.lender,
  });

  factory LenderService.fromJson(Map<String, dynamic> json) {
    return LenderService(
      serviceDesc: json['serviceDesc'],
      lender: Lender.fromJson(json['lender']),
    );
  } 
}

class Lender {
  final int id;
  final String lenderName;
  final String lenderDesc;
  final String lenderEmail;
  final String lenderPhone;
  final String? photo;
  final bool active;

  Lender({
    required this.id,
    required this.lenderName,
    required this.lenderDesc,
    required this.lenderEmail,
    required this.lenderPhone,
    required this.photo,
    required this.active,
  });

  factory Lender.fromJson(Map<String, dynamic> json) {
    return Lender(
      id: json['id'],
      lenderName: json['lenderName'],
      lenderDesc: json['lenderDesc'],
      lenderEmail: json['lenderEmail'],
      lenderPhone: json['lenderPhone'],
      photo: json['photo'],
      active: json['active'],
    );
  }
}
