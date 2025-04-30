import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Widget que muestra el enlace para registrarse.
/// Se centra en la pantalla y utiliza estilos tipográficos centralizados.
class RegisterLink extends StatelessWidget {
  const RegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Aquí podrías agregar la navegación a la pantalla de registro
        },
        child: Text(
          'Quiero registrarme',
          style: AppTextStyles.linkBold(context), // Estilo responsivo centralizado
        ),
      ),
    );
  }
}
