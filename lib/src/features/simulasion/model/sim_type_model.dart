// lib/src/features/simulacion/models/sim_type_model.dart

class SimType {
  final int id;
  final String name;

  SimType({required this.id, required this.name});

  factory SimType.fromJson(Map<String, dynamic> json) {
    return SimType(
      id: json['id'],
      name: json['name'],
    );
  }
}