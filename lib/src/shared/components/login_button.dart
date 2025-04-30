import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Botón primario reutilizable con texto personalizado y estado de carga.
class PrimaryButton extends StatelessWidget {
  final String label; // Texto del botón
  final bool isLoading; // Estado de carga (muestra spinner)
  final VoidCallback onPressed; // Acción al presionar

  const PrimaryButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonForeground,
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: AppTextStyles.buttonText(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: AppColors.buttonForeground)
          : Text(label),
    );
  }
}
