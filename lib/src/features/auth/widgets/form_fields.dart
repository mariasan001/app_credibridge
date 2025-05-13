import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Campo de texto para el número de Servidor Público.
/// Reutilizable y con estilos responsive.
class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Número de Servidor público *',
        hintText: 'Ingresa número',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel(context).copyWith(
          fontSize: isTablet ? 20 : 16,
        ),
        hintStyle: AppTextStyles.inputHint(context).copyWith(
          fontSize: isTablet ? 16 : 14,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(color: AppColors.inputBorder(context)),

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
                    borderSide:  BorderSide(color: AppColors.inputBorder(context)),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: (value) => value == null || value.isEmpty
          ? 'Por favor ingresa tu número de servidor'
          : null,
    );
  }
}
