import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RichText(
      text: TextSpan(
        style: AppTextStyles.logoText(context).copyWith(
          fontSize: 42.sp,
          fontWeight: FontWeight.w800,
        ),
        children: [
          TextSpan(
            text: 'Credi',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 42.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'Bridge.',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 42.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
