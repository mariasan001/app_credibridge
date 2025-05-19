import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle logoText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 36.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.text(context),
    );
  }

  static TextStyle logoHighlight(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 36.sp,
      color: AppColors.primary,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle inputLabel(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.text(context),
    );
  }

  static TextStyle inputHint(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      color: Colors.black45,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle linkMuted(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    );
  }

  static TextStyle linkBold(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.text(context),
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13.sp,
      color: Colors.black54,
    );
  }

  static TextStyle heading(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoTitle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoBold(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoBody(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13.sp,
      color: AppColors.textMuted(context),
    );
  }

  static TextStyle promoListText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13.sp,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoFooterDate(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 13.sp,
      color: AppColors.textMuted(context),
    );
  }

  static TextStyle promoButtonText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.text(context),
    );
  }

  static TextStyle titleheader(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 24.sp,
      fontWeight: FontWeight.w800,
      color: AppColors.text(context),
    );
  }
}
