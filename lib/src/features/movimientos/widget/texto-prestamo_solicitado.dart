import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
class TextoPrestamoSolicitado extends StatelessWidget {
  final double monto;

  const TextoPrestamoSolicitado({super.key, required this.monto});

  @override
  Widget build(BuildContext context) {
    final montoFormateado =
        NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(monto);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.bodySmall(context).copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted(context),
        ),
        children: [
          const TextSpan(text: 'De un préstamo solicitado de '),
          TextSpan(
            text: '$montoFormateado MX',
            style: AppTextStyles.bodySmall(context).copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700, // 🔥 Más grueso
              color: AppColors.textMuted(context),
            ),
          ),
        ],
      ),
    );
  }
}
