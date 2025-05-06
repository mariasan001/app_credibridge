import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Widget que muestra el enlace para recuperación de contraseña.
/// Se ubica alineado a la derecha y navega a la pantalla correspondiente.
class RecoveryLink extends StatelessWidget {
  const RecoveryLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navega a la página de recuperación de contraseña
          Navigator.pushNamed(context, '/Rcorreo');
        },
        child: Text(
          'Olvidé mi contraseña',
          style: AppTextStyles.linkMuted(context),
        ),
      ),
    );
  }
}
