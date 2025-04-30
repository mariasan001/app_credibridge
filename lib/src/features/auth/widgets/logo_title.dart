// Widget que representa el logotipo textual de la aplicación

import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart'; // Estilos centralizados

class LogoTitle extends StatelessWidget {
  const LogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // Detectamos si estamos en una tablet o en celular
    final isTablet = MediaQuery.of(context).size.width > 600;

    return RichText(
      // Permite combinar estilos en una sola línea de texto
      text: TextSpan(
        // Estilo base para todo el texto, sobrescribiendo tamaño y peso
        style: AppTextStyles.logoText(context).copyWith(
          fontSize: isTablet ? 58 : 42, // Tamaño más grande en tablet
          fontWeight: FontWeight.w800, // Extra negrita
        ),
        children: [
          // Texto "Credi" con estilo base
          const TextSpan(text: 'Credi'),

          // Texto "Bridge." con estilo de color destacado
          TextSpan(
            text: 'Bridge.',
            style: AppTextStyles.logoHighlight(context).copyWith(
              fontWeight: FontWeight.w800, // Negrita más fuerte
              fontSize: isTablet ? 58 : 42, // Coincide con el tamaño del logo
            ),
          ),
        ],
      ),
    );
  }
}
