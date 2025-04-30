import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Widget que muestra el enlace para recuperación de contraseña.
/// Se ubica alineado a la derecha y usa estilos centralizados.
class RecoveryLink extends StatelessWidget {
  const RecoveryLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, // Posiciona el botón al extremo derecho
      child: TextButton(
        onPressed: () {
          // Aquí podrías agregar la navegación a la pantalla de recuperación
        },
        child: Text(
          'Olvidé mi contraseña',
          style: AppTextStyles.linkMuted(context), // Usa estilo de texto centralizado y responsivo
        ),
      ),
    );
  }
}
