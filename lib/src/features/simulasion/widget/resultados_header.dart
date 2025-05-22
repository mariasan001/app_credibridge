import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadosHeader extends StatelessWidget {
  const ResultadosHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(8.r),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
              SizedBox(width: 4.w),
              Text(
                'Solicitar Préstamo',
                style: AppTextStyles.titleheader(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Gestiona tu cuenta de manera rápida y sencilla.',
          style: AppTextStyles.bodySmall(context).copyWith(
            color: AppColors.text(context),
          ),
        ),
      ],
    );
  }
}
