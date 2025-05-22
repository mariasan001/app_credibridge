import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class Dato extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final bool isBold;
  final bool isLabelBold;
  final bool big;

  const Dato({
    super.key,
    required this.label,
    required this.value,
    this.color,
    this.isBold = false,
    this.isLabelBold = false,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: isLabelBold ? FontWeight.bold : FontWeight.normal,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              fontSize: big ? 16.sp : 14.sp,
              color: color ?? AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }
}
