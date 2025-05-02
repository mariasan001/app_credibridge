import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class NumeroServidorField extends StatelessWidget {
  final TextEditingController controller;

  const NumeroServidorField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:  controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Número de Servidor Público *',
        hintText: 'Ej. 123456',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel(context),
        hintStyle: AppTextStyles.inputHint(context),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator:
          (value) =>
              (value == null || value.isEmpty)
                  ? 'Este campo es obligatorio'
                  : null,
    );
  }
}
