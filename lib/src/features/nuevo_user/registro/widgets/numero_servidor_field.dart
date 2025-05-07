import 'package:flutter/material.dart';

import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Campo de texto personalizado para capturar el número de servidor público.
/// Este campo es obligatorio y sólo permite números.
class NumeroServidorField extends StatelessWidget {
  final TextEditingController controller;

  const NumeroServidorField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }
}
class PlazaField extends StatelessWidget {
  final TextEditingController controller;

  const PlazaField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Plaza *',
        hintText: 'Ej. 000000000000000',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel(context),
        hintStyle: AppTextStyles.inputHint(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }
}
class JobCodeField extends StatelessWidget {
  final TextEditingController controller;

  const JobCodeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Código de Puesto *',
        hintText: 'Ej. A0A00A00A',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel(context),
        hintStyle: AppTextStyles.inputHint(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }
}

class RfcField extends StatelessWidget {
  final TextEditingController controller;

  const RfcField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
        labelText: 'RFC *',
        hintText: 'Ej. 0A0A0A0A0A',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.inputLabel(context),
        hintStyle: AppTextStyles.inputHint(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }
}
