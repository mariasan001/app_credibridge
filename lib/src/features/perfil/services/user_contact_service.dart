import 'package:app_creditos/src/shared/services/api_service.dart';

class ContactService {
  static Future<void> actualizarContacto({
    required String userId,
    required String email,
    required String phone,
  }) async {
    final body = {"email": email, "phone": phone};

    final response = await ApiService.dio.put(
      '/api/users/$userId/contact',
      data: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el contacto');
    }
  }
}
