class LenderModel {
  final int id;
  final String lenderName;

  LenderModel({
    required this.id,
    required this.lenderName,
  });

  factory LenderModel.fromJson(Map<String, dynamic> json) {
    return LenderModel(
      id: json['id'],
      lenderName: json['lenderName'],
    );
  }
}
