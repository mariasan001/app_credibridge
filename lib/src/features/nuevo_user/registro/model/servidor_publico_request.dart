class ServidorPublicoRequest {
  final String userId;
  final String workUnit;
  final String jobCode;
  final String rfc;

  ServidorPublicoRequest({
    required this.userId,
    required this.workUnit,
    required this.jobCode,
    required this.rfc,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'workUnit': workUnit,
      'jobCode': jobCode,
      'rfc': rfc,
    };
  }
}
