import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// 🎨 Decoración base adaptada para modo oscuro
InputDecoration buildInputDecoration(
  BuildContext context, {
  required String label,
  required String hint,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return InputDecoration(
    labelText: label,
    hintText: hint,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: AppTextStyles.inputLabel(context),
    hintStyle: AppTextStyles.inputHint(context).copyWith(
      color: isDark ? Colors.white70 : AppColors.textMuted(context),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    filled: true,
    fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF9F9F9),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.inputBorder(context)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.inputBorder(context)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
  );
}

/// 📌 Campo: Número de Servidor Público
class NumeroServidorField extends StatelessWidget {
  final TextEditingController controller;

  const NumeroServidorField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration(
        context,
        label: 'Número de Servidor Público *',
        hint: 'Ej. 123456',
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

/// 📌 Campo: Unidad Administrativa (workUnit)
class WorkUnitField extends StatelessWidget {
  final TextEditingController controller;

  const WorkUnitField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(
        context,
        label: 'Unidad Administrativa *',
        hint: 'Ej. SEyGEM000000000000',
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

/// 📌 Campo: Código de Puesto
class JobCodeField extends StatelessWidget {
  final TextEditingController controller;

  const JobCodeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(
        context,
        label: 'Código de Puesto *',
        hint: 'Ej. A0A00A00A',
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

/// 📌 Campo: RFC
class RfcField extends StatelessWidget {
  final TextEditingController controller;

  const RfcField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.characters,
      decoration: buildInputDecoration(
        context,
        label: 'RFC *',
        hint: 'Ej. 0A0A0A0A0A',
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
