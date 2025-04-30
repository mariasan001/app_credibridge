import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Logo principal
  static final TextStyle logoText = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static final TextStyle logoHighlight = GoogleFonts.poppins(
    color: AppColors.primary,
    fontWeight: FontWeight.w900,
  );

  // Etiquetas de formularios
  static final TextStyle inputLabel = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static final TextStyle inputHint = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black45,
  );

  // Texto de botones principales
  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Texto para links o enlaces secundarios
  static final TextStyle linkMuted = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  static final TextStyle linkBold = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  // Texto de cuerpo pequeño
  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.black54,
  );

  // Encabezados
  static final TextStyle heading = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
}
