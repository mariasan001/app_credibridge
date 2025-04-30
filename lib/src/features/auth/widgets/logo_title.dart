// Widget que representa el logotipo textual de la aplicación

import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart'; // Estilos centralizados

class LogoTitle extends StatelessWidget {
  const LogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      // Permite combinar estilos en una sola línea de texto
      text: TextSpan(
        // Estilo base para todo el texto (fuente, tamaño y color)
        style: AppTextStyles.logoText.copyWith(
          fontSize: 58, // Tamaño sobrescrito para hacerlo más llamativo
          fontWeight: FontWeight.w800, // Peso extra negrita
        ),
        children: [
          // Parte "Credi" con estilo base
          const TextSpan(text: 'Credi'),
          // Parte "Bridge." con color primario y negrita personalizada
          TextSpan(
            text: 'Bridge.',
            style: AppTextStyles.logoHighlight.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
