class ContratoModel {
  final int lenderId;
  final String userId;
  final int contractType;
  final int installments;
  final double amount;
  final int biweeklyDiscount;
  final double effectiveRate;
  final double effectiveAnnualRate;
  final String phone;

  ContratoModel({
    required this.lenderId,
    required this.userId,
    required this.contractType,
    required this.installments,
    required this.amount,
    required this.biweeklyDiscount,
    required this.effectiveRate,
    required this.effectiveAnnualRate,
    required this.phone, 
  });

Map<String, dynamic> toJson() {
  return {
    "lenderId": lenderId, 
    "userId": userId,
    "contractType": contractType,
    "installments": installments,
    "amount": amount,
    "biweeklyDiscount": biweeklyDiscount,
    "effectiveRate": effectiveRate,
    "effectiveAnnualRate": effectiveAnnualRate,
    "phone": phone,
  };
}

}
