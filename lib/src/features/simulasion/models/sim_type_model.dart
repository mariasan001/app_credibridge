class SimType {
  final int id;
  final String name;

  SimType({
    required this.id,
    required this.name,
  });

  factory SimType.fromJson(Map<String, dynamic> json) {
    return SimType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
