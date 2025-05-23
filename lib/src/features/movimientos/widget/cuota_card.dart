import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CuotaCard extends StatelessWidget {
  final int value;
  final String label;

  const CuotaCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.teal[700],
              height: 1.2,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.text(context),
            ),
          ),
        ],
      ),
    );
  }
}
