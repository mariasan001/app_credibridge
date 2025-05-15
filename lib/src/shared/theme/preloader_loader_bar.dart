import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

/// Barra de carga horizontal utilizada en el preloader.
/// Se adapta automáticamente al tema y utiliza el color primario institucional.
class PreloaderLoaderBar extends StatelessWidget {
  const PreloaderLoaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: LinearProgressIndicator(
        minHeight: 5,
        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
        backgroundColor: AppColors.primary.withOpacity(0.2),
      ),
    );
  }
}
