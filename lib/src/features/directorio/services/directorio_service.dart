import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';

class DirectorioService {
  static Future<List<LenderServiceGrouped>> obtenerServiciosActivos() async {
    try {
      final response = await ApiService.dio.get('/api/lenderServices/active-grouped');

      return (response.data as List)
          .map((item) => LenderServiceGrouped.fromJson(item))
          .toList();
    } catch (e) {
      throw 'No se pudieron obtener los servicios activos';
    }
  }
}
