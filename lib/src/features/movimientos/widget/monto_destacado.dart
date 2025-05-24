import 'package:app_creditos/src/shared/theme/app_colors.dart' show AppColors;
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MontoDestacado extends StatelessWidget {
  final double monto;
  final String tipo; // Tipo de servicio: préstamo, seguro, otro

  const MontoDestacado({
    super.key,
    required this.monto,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'es_MX', symbol: '', decimalDigits: 2);
    final partes = formatter.format(monto).split('.');

    // 🎨 Determinar color según tipo de servicio
    Color colorPrincipal;
    if (tipo.toLowerCase().contains('préstamo') || tipo.toLowerCase().contains('prestamo')) {
      colorPrincipal = AppColors.primary;
    } else if (tipo.toLowerCase().contains('seguro')) {
      colorPrincipal = AppColors.cardtextfondo(context);
    } else {
      colorPrincipal = Colors.grey.shade600;
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\$${partes[0]}.',
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 40.sp,
              fontWeight: FontWeight.w900,
              color: colorPrincipal,
            ),
          ),
          TextSpan(
            text: partes[1],
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: colorPrincipal.withOpacity(0.7),
            ),
          ),
          TextSpan(
            text: ' mx',
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
