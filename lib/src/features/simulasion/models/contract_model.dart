class Contract {
  final String userId;
  final int lenderServiceId;
  final int lenderId;
  final int documentation;
  final int contractType;
  final int installments;
  final double amount;
  final double monthlyDeductionAmount;
  final double effectiveRate;
  final String phone;
  final int contractStatusId;
  final int creditId;
  final double annualRate;
  final int termMonths;
  final String startDate;
  final String endAt;
  final String paymentFrequency;

  Contract({
    required this.userId,
    required this.lenderServiceId,
    required this.lenderId,
    required this.documentation,
    required this.contractType,
    required this.installments,
    required this.amount,
    required this.monthlyDeductionAmount,
    required this.effectiveRate,
    required this.phone,
    required this.contractStatusId,
    required this.creditId,
    required this.annualRate,
    required this.termMonths,
    required this.startDate,
    required this.endAt,
    required this.paymentFrequency,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "lenderServiceId": lenderServiceId,
    "lenderId": lenderId,
    "documentation": documentation,
    "contractType": contractType,
    "installments": installments,
    "amount": amount,
    "monthlyDeductionAmount": monthlyDeductionAmount,
    "effectiveRate": effectiveRate,
    "phone": phone,
    "contractStatusId": contractStatusId,
    "creditId": creditId,
    "annualRate": annualRate,
    "termMonths": termMonths,
    "startDate": startDate,
    "endAt": endAt,
    "paymentFrequency": paymentFrequency,
  };
}
