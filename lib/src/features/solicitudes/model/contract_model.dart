class ContractModel {
  final int contractId;
  final int installments;
  final int discountsAplied;
  final double biweeklyDiscount;
  final double amount;
  final double effectiveRate;
  final double anualRate;
  final double lastBalance;
  final double newBalance;

  final String userId;
  final String userName;
  final String lenderName;
  final String lenderServiceDesc;
  final String serviceTypeDesc;
  final String contractStatusDesc;

  ContractModel({
    required this.contractId,
    required this.installments,
    required this.discountsAplied,
    required this.biweeklyDiscount,
    required this.amount,
    required this.effectiveRate,
    required this.anualRate,
    required this.lastBalance,
    required this.newBalance,
    required this.userId,
    required this.userName,
    required this.lenderName,
    required this.lenderServiceDesc,
    required this.serviceTypeDesc,
    required this.contractStatusDesc,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final lender = json['lender'] ?? {};
    final contractStatus = json['contractStatus'] ?? {};
    final lenderService = json['lenderService'] ?? {};
    final serviceType = lenderService['serviceType'] ?? {};

    return ContractModel(
      contractId: json['contractId'] ?? 0,
      installments: json['installments'] ?? 0,
      discountsAplied: json['discountsAplied'] ?? 0,
      biweeklyDiscount: (json['biweeklyDiscount'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      effectiveRate: (json['effectiveRate'] ?? 0).toDouble(),
      anualRate: (json['anualRate'] ?? 0).toDouble(),
      lastBalance: (json['lastBalance'] ?? 0).toDouble(),
      newBalance: (json['newBalance'] ?? 0).toDouble(),
      userId: user['userId'] ?? '',
      userName: user['name'] ?? '',
      lenderName: lender['lenderName'] ?? '',
      lenderServiceDesc: lenderService['lenderServiceDesc'] ?? '',
      serviceTypeDesc: serviceType['serviceTypeDesc'] ?? '',
      contractStatusDesc: contractStatus['contractStatusDesc'] ?? '',
    );
  }
}
