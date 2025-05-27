class ClarificationTypeModel {
  final int id;
  final String clarificationTypeDesc;

  ClarificationTypeModel({
    required this.id,
    required this.clarificationTypeDesc,
  });

  factory ClarificationTypeModel.fromJson(Map<String, dynamic> json) {
    return ClarificationTypeModel(
      id: json['id'],
      clarificationTypeDesc: json['clarificationTypeDesc'] ?? '',
    );
  }
}
