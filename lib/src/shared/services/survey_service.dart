import 'package:app_creditos/src/shared/model/survey_response_model.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:app_creditos/src/shared/services/survey_model.dart';

class SurveyService {
  /// Obtiene las encuestas del servidor
  Future<List<Survey>> fetchSurveys() async {
    try {
      final response = await ApiService.dio.get('/api/surveys');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Survey.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener encuestas: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error en fetchSurveys: $e');
      rethrow;
    }
  }

  /// Envía las respuestas de la encuesta
  Future<void> enviarEncuesta({
    required String userId,
    required int lenderId,
    required List<SurveyResponse> respuestas,
  }) async {
    final data = {
      "userId": userId,
      "lenderId": lenderId,
      "responses": respuestas.map((r) => r.toJson()).toList(),
    };

    try {
      final response = await ApiService.dio.post(
        '/api/surveys',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Encuesta enviada correctamente.");
      } else {
        throw Exception('Error al enviar encuesta: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error en enviarEncuesta: $e');
      rethrow;
    }
  }
}
