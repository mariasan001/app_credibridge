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
  int? lenderServiceId;
  String? lenderName;

  // Capital ofrecido
  double? capital;

 
  double? descuento;

  // Constructor actualizado
  SolicitudCreditoData({
    this.userId,
    this.tipoSimulacion,
    this.monto,
    this.plazo,
    this.tasaAnual,
    this.tasaPorPeriodo,
    this.lenderServiceId,
    this.lenderName,
    this.capital,
    this.descuento, 
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
      'lenderServiceId': lenderServiceId,
      'lenderName': lenderName,
      'capital': capital,
      'descuento': descuento,
    };
  }

  @override
  String toString() => toJson().toString();
}
