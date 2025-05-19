import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Campo de texto para el número de Servidor Público.
class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Número de Servidor público *',
        hintText: 'Ingresa número',
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // ✅ Estilos adaptados
        labelStyle: AppTextStyles.inputLabel(context).copyWith(
          fontSize: 16.sp,
          color: AppColors.text(context),
        ),
        hintStyle: AppTextStyles.inputHint(context).copyWith(
          fontSize: 14.sp,
          color: AppColors.textMuted(context),
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        // ✅ Bordes
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.inputBorder(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.inputBorder(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),

        // ✅ Fondo adaptativo
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF9F9F9),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Por favor ingresa tu número de servidor' : null,
    );
  }
}
