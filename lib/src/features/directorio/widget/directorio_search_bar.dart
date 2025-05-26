import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class DirectorioSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool isDark;

  const DirectorioSearchBar({
    super.key,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.text(context),
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: 'Buscar servicio o institución',
        hintStyle: AppTextStyles.inputHint(context).copyWith(
          fontSize: 13.sp,
          color: AppColors.textMuted(context),
        ),
        prefixIcon: const Icon(Icons.search, size: 20),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
