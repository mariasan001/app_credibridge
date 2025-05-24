import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
class TextoPrestamoSolicitado extends StatelessWidget {
  final double monto;
  final String tipo;

  const TextoPrestamoSolicitado({
    super.key,
    required this.monto,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    final montoFormateado =
        NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(monto);

    final isPrestamo = tipo.toLowerCase().contains('préstamo') || tipo.toLowerCase().contains('prestamo');
    final isSeguro = tipo.toLowerCase().contains('seguro');

    if (isPrestamo) {
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
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted(context),
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        isSeguro
            ? "Tu seguro está vigente desde el 1 Ene 2024"
            : "Servicio activo desde el 1 Ene 2024",
        style: AppTextStyles.bodySmall(context).copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}
