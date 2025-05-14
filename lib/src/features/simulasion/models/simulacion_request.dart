// lib/src/features/simulacion/models/simulacion_request.dart

class SimulacionRequest {
  final String userId;
  final int simTypeId;
  final int periods;
  final double paymentAmount;

  SimulacionRequest({
    required this.userId,
    required this.simTypeId,
    required this.periods,
    required this.paymentAmount,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'simTypeId': simTypeId,
        'periods': periods,
        'paymentAmount': paymentAmount,
      };
}