import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';

class SolicitudCreditoData {
  // Datos del usuario
  int? userId;

  // Tipo de simulación
  SimType? tipoSimulacion;

  // Información del préstamo
  double? monto;
  int? plazo;

  // Tasas
  double? tasaAnual;
  double? tasaPorPeriodo;

  // Financiera seleccionada
  int? lenderId;
  String? lenderName;


  double? capital;

  SolicitudCreditoData({
    this.userId,
    this.tipoSimulacion,
    this.monto,
    this.plazo,
    this.tasaAnual,
    this.tasaPorPeriodo,
    this.lenderId,
    this.lenderName,
    this.capital,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'tipoSimulacion': tipoSimulacion != null
    ? {'id': tipoSimulacion!.id, 'name': tipoSimulacion!.name}
    : null,

      'monto': monto,
      'plazo': plazo,
      'tasaAnual': tasaAnual,
      'tasaPorPeriodo': tasaPorPeriodo,
      'lenderId': lenderId,
      'lenderName': lenderName,
      'capital': capital,
    };
  }

  @override
  String toString() => toJson().toString();
}
