// lib/src/features/simulacion/services/simulacion_service.dart

import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_request.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class SimulacionService {
  final _dio = ApiService.dio;

  // ✅ Obtener los tipos disponibles
  Future<List<SimType>> obtenerTiposSimulacion() async {
    try {
      final response = await _dio.get('/api/sim-types');
      final data = response.data as List;
      return data.map((json) => SimType.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener tipos de simulación: $e');
    }
  }

  // ✅ Ejecutar simulación
  Future<List<SimulacionResult>> simularPrestamo(SimulacionRequest request) async {
    try {
      final response = await _dio.post(
        '/api/simulations/discount',
        data: request.toJson(),
      );
      final data = response.data as List;
      return data.map((json) => SimulacionResult.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al simular préstamo: $e');
    }
  }
}
