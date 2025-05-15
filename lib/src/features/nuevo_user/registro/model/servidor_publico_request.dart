class ServidorPublicoRequest {
  final String userId;
  final String plaza;
  final String jobCode;
  final String rfc;

  ServidorPublicoRequest({
    required this.userId,
    required this.plaza,
    required this.jobCode,
    required this.rfc, 
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'plaza': plaza,
      'jobCode': jobCode,
      'rfc': rfc,
    };
  }
}
