
// conexion  para el extracion de los contratos  /activos/ en proceso por usario 
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class ContractService {
  static Future<List<ContractModel>> getContractsByUser(String userId) async {
    try {
      final response = await ApiService.dio.get('/api/contracts/user/$userId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ContractModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener contratos');
      }
    } catch (e) {
      print('Error al obtener contratos: $e');
      rethrow;
    }
  }
}
