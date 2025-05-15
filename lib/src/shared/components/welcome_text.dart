import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Widget que muestra un encabezado de bienvenida dinámico y responsivo.
/// Se puede reutilizar en diferentes pantallas como login, registro, recuperación, etc.
class WelcomeText extends StatelessWidget {
  final String titlePrefix;      // Ej: "Bienvenidos a"
  final String titleHighlight;  // Ej: "CrediBridge"
  final String titleSuffix;     // Ej: "toma el control de tus finanzas"
  final String subtitle;        // Ej: "Introduce tu información y descubre tus opciones..."

  const WelcomeText({
    super.key,
    required this.titlePrefix,
    required this.titleHighlight,
    required this.titleSuffix,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Texto fijo de saludo
        Text(
          'Buenos días 👋',
          style: AppTextStyles.bodySmall(context).copyWith(
            fontSize: isTablet ? 18 : 16,
            fontWeight: FontWeight.w300,
            color: const Color.fromARGB(255, 79, 79, 79),
          ),
        ),
        const SizedBox(height: 10),

        // Título principal dinámico
        RichText(
          text: TextSpan(
            style: AppTextStyles.heading(context).copyWith(
              fontSize: isTablet ? 36 : 27.5,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
            children: [
              TextSpan(text: '$titlePrefix '),
              TextSpan(
                text: titleHighlight,
                style: AppTextStyles.logoHighlight(context).copyWith(
                  fontSize: isTablet ? 36 : 27.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(text: ' $titleSuffix'),
            ],
          ),
        ),
        const SizedBox(height: 4),

        // Subtítulo personalizado
        Text(
          subtitle,
          style: AppTextStyles.bodySmall(context).copyWith(
            fontSize: isTablet ? 16 : 14,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
