class DescuentoResponse {
  final double amount;

  DescuentoResponse({required this.amount});

  factory DescuentoResponse.fromJson(Map<String, dynamic> json) {
    return DescuentoResponse(
      amount: (json['amount'] as num).toDouble(),
    );
  }
}
