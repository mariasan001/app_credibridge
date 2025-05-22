class ContractModel {
  final int id;
  final String userId;
  final int? documentation;
  final int? contractType;
  final int? installments;
  final double amount;
  final double monthlyDeductionAmount;
  final double? effectiveRate;
  final String? phone;
  final int? contractStatusId;
  final String? contractStatusDesc;
  final String? creditId;
  final String? updatedAt;
  final String? modificatedUser;
  final double? anualRate;
  final int? termMonths;
  final String? startDate;
  final String? endAt;
  final String? paymentFrequency;
  final String? createdAt;
  final String? nextPaymentDate;
  final double paymentAmount;

  ContractModel({
    required this.id,
    required this.userId,
    this.documentation,
    this.contractType,
    this.installments,
    required this.amount,
    required this.monthlyDeductionAmount,
    this.effectiveRate,
    this.phone,
    this.contractStatusId,
    this.contractStatusDesc,
    this.creditId,
    this.updatedAt,
    this.modificatedUser,
    this.anualRate,
    this.termMonths,
    this.startDate,
    this.endAt,
    this.paymentFrequency,
    this.createdAt,
    this.nextPaymentDate,
    required this.paymentAmount,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'],
      userId: json['userId'],
      documentation: json['documentation'],
      contractType: json['contractType'],
      installments: json['installments'],
      amount: (json['amount'] ?? 0).toDouble(),
      monthlyDeductionAmount: (json['monthlyDeductionAmount'] ?? 0).toDouble(),
      effectiveRate: (json['effectiveRate'] ?? 0).toDouble(),
      phone: json['phone'],
      contractStatusId: json['contractStatusId'],
      contractStatusDesc: json['contractStatusDesc'],
      creditId: json['creditId'],
      updatedAt: json['updatedAt'],
      modificatedUser: json['modificatedUser'],
      anualRate: (json['anualRate'] ?? 0).toDouble(),
      termMonths: json['termMonths'],
      startDate: json['startDate'],
      endAt: json['endAt'],
      paymentFrequency: json['paymentFrequency'],
      createdAt: json['createdAt'],
      nextPaymentDate: json['nextPaymentDate'],
      paymentAmount: (json['paymentAmount'] ?? 0).toDouble(),
    );
  }
}
