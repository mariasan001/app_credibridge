import 'package:app_creditos/src/features/simulasion/models/contract_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class ContractService {
  Future<void> createContract(Contract contract) async {
    try {
      final response = await ApiService.dio.post(
        '/api/contracts',
        data: contract.toJson(),
      );
      print('✅ Contrato creado: ${response.data}');
    } catch (e) {
      print('❌ Error al crear contrato: $e');
      rethrow;
    }
  }
}
