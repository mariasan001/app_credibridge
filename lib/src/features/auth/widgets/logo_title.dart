import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.logoText(context).copyWith(
          fontSize: 42.sp,
          fontWeight: FontWeight.w800,
        ),
        children: [
          const TextSpan(text: 'Credi'),
          TextSpan(
            text: 'Bridge.',
            style: AppTextStyles.logoHighlight(context).copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 42.sp,
            ),
          ),
        ],
      ),
    );
  }
}
