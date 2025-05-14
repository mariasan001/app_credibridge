// lib/src/features/simulacion/models/simulacion_result.dart

class SimulacionResult {
  final int lenderServiceId;
  final int lenderId;
  final String lenderName;
  final int serviceTypeId;
  final String serviceTypeDesc;
  final double capital;
  final double effectivePeriodRate;
  final double effectiveAnnualRate;

  SimulacionResult({
    required this.lenderServiceId,
    required this.lenderId,
    required this.lenderName,
    required this.serviceTypeId,
    required this.serviceTypeDesc,
    required this.capital,
    required this.effectivePeriodRate,
    required this.effectiveAnnualRate,
  });

  factory SimulacionResult.fromJson(Map<String, dynamic> json) {
    return SimulacionResult(
      lenderServiceId: json['lenderServiceId'],
      lenderId: json['lenderId'],
      lenderName: json['lenderName'],
      serviceTypeId: json['serviceTypeId'],
      serviceTypeDesc: json['serviceTypeDesc'],
      capital: json['capital'].toDouble(),
      effectivePeriodRate: json['effectivePeriodRate'].toDouble(),
      effectiveAnnualRate: json['effectiveAnnualRate'].toDouble(),
    );
  }
}
