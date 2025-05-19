import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

/// Botón primario reutilizable con estilo responsivo y estado de carga.
class PrimaryButton extends StatelessWidget {
  final String label;          // Texto del botón
  final bool isLoading;        // Muestra spinner si está en carga
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // O usa 1.sw para ocupar todo el ancho
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.buttonForeground,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          textStyle: AppTextStyles.buttonText(context).copyWith(fontSize: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: const CircularProgressIndicator(
                  color: AppColors.buttonForeground,
                  strokeWidth: 2,
                ),
              )
            : Text(label),
      ),
    );
  }
}
