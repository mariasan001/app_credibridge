import 'package:app_creditos/src/features/inicio/model/Crea%20tu%20archivo%20model_promociones.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';

class PromotionService {
  static Future<List<Promotion>> obtenerPromocionesActivas() async {
    final response = await ApiService.dio.get('/lender-promotions/active');

    final List<dynamic> data = response.data;
    return data.map((json) => Promotion.fromJson(json)).toList();
  }
}
