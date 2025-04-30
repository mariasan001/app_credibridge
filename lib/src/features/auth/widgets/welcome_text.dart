// lib/src/features/auth/widgets/welcome_text.dart
import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buenos días 👋',
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: const Color.fromARGB(255, 79, 79, 79),
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: AppTextStyles.heading.copyWith(fontSize: 36, fontWeight: FontWeight.w700, height: 1),
            children: [
              const TextSpan(text: 'Bienvenidos a '),
              TextSpan(text: 'CrediBridge ', style: AppTextStyles.logoHighlight.copyWith(fontSize: 36, fontWeight: FontWeight.w900)),
              const TextSpan(text: 'toma el control de tus finanzas'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Introduce tu información y descubre tus opciones de crédito.',
          style: AppTextStyles.bodySmall.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
