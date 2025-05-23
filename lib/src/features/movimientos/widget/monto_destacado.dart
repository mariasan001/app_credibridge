import 'package:app_creditos/src/shared/theme/app_colors.dart' show AppColors;
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MontoDestacado extends StatelessWidget {
  final double monto;
  const MontoDestacado({super.key, required this.monto});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'es_MX', symbol: '', decimalDigits: 2);
    final partes = formatter.format(monto).split('.');

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\$${partes[0]}.',
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 42.sp,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          TextSpan(
            text: '${partes[1]} mx',
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
