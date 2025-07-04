import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

/// Encabezado reutilizable con bienvenida, título y subtítulo.
/// Perfecto para login, registro, recuperación, etc.
class WelcomeText extends StatelessWidget {
  final String titlePrefix;
  final String titleHighlight;
  final String titleSuffix;
  final String subtitle;

  const WelcomeText({
    super.key,
    required this.titlePrefix,
    required this.titleHighlight,
    required this.titleSuffix,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🟡 Texto superior de saludo
        Text(
          'Buenos días 👋',
          style: AppTextStyles.bodySmall(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: AppColors.text(context),
          ),
        ),
        SizedBox(height: 10.h),

        // 🔵 Título con estilo destacado
        RichText(
          text: TextSpan(
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 1,
              color: AppColors.text(context),
            ),
            children: [
              TextSpan(text: '$titlePrefix '),
              TextSpan(
                text: titleHighlight,
                style: AppTextStyles.logoHighlight(context).copyWith(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                  
                ),
              ),
              TextSpan(text: ' $titleSuffix'),
            ],
          ),
        ),
        SizedBox(height: 4.h),

        // 🔹 Subtítulo explicativo
        Text(
          subtitle,
          style: AppTextStyles.bodySmall(context).copyWith(
            fontSize: 13.sp,
            color: AppColors.textMuted(context),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
