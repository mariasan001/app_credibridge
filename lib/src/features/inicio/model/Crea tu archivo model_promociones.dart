class Promotion {
  final int id;
  final String promotionTitle;
  final String promotionDesc;
  final String startDate;
  final String endDate;
  final String webIcon;
  final String mobileIcon;
  final String lenderName;
  final String serviceTypeDesc;
  final List<String> benefits;

  Promotion({
    required this.id,
    required this.promotionTitle,
    required this.promotionDesc,
    required this.startDate,
    required this.endDate,
    required this.webIcon,
    required this.mobileIcon,
    required this.lenderName,
    required this.serviceTypeDesc,
    required this.benefits,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    final lenderService = json['lenderService'];
    final lender = lenderService?['lender'];
    final serviceType = lenderService?['serviceType'];

    return Promotion(
      id: json['id'],
      promotionTitle: json['promotionTitle'] ?? '',
      promotionDesc: json['promotionDesc'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      webIcon: json['webIcon'] ?? '',
      mobileIcon: json['mobileIcon'] ?? '',
      lenderName: lender?['lenderName'] ?? '',
      serviceTypeDesc: serviceType?['serviceTypeDesc'] ?? '',
      benefits: (json['benefits'] as List<dynamic>)
          .map((b) => b['benefitsDesc'].toString())
          .toList(),
    );
  }
}
