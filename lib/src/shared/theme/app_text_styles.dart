import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

bool _isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width > 600;
}

class AppTextStyles {
  static TextStyle logoText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 58 : 36,
      fontWeight: FontWeight.bold,
      color: AppColors.text(context),
    );
  }

  static TextStyle logoHighlight(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 58 : 36,
      color: AppColors.primary,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle inputLabel(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 20 : 16,
      fontWeight: FontWeight.w500,
      color: AppColors.text(context),
    );
  }

  static TextStyle inputHint(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 16 : 14,
      color: Colors.black45,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 18 : 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle linkMuted(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 14 : 13,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    );
  }

  static TextStyle linkBold(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 14 : 13,
      fontWeight: FontWeight.w500,
      color: AppColors.text(context),
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 14 : 13,
      color: Colors.black54,
    );
  }

  static TextStyle heading(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 22 : 18,
      fontWeight: FontWeight.bold,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoTitle(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 20 : 18,
      fontWeight: FontWeight.bold,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoBold(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 16 : 14,
      fontWeight: FontWeight.w600,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoBody(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 14.5 : 13,
      color: AppColors.textMuted(context),
    );
  }

  static TextStyle promoListText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 15 : 13,
      color: AppColors.text(context),
    );
  }

  static TextStyle promoFooterDate(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 14 : 13,
      color: AppColors.textMuted(context),
    );
  }

  static TextStyle promoButtonText(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: _isTablet(context) ? 16 : 14,
      fontWeight: FontWeight.w600,
      color: AppColors.text(context),
    );
  }
}
