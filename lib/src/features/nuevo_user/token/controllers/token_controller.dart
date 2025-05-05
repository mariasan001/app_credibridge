// nuevo_user/token/controller/token_controller.dart

import 'package:app_creditos/src/features/nuevo_user/token/services/token_services.dart';

class TokenController {
  static Future<String?> validarToken(String code) async {
    if (code.isEmpty || code.length < 6) {
      return 'Ingresa un código válido';
    }

    try {
      await TokenService.verificarToken(
        code: code,
        newPassword: 'temporal123',
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
