import 'package:flutter/material.dart';

class AppColors {
  // 🌞🌚 Dependientes del tema

  static Color inputBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2A2A2A)
          : const Color(0xFFF6F6F6);

  static Color cardBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1E1E1E)
          : Colors.white;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1E1E1E)
          : const Color(0xFFFCF8F2);

  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;

  static Color textMuted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white70
          : Colors.black54;

  static Color inputBorder(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.black26;

  static Color borderBotton(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black26
          : const Color.fromARGB(255, 255, 255, 255);

  static Color promoCardBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2A2A2A)
          : Colors.white;

  static Color promoShadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black26
          : const Color(0x11000000);
static Color divider(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[700]! 
        : Colors.grey[300]!;

  // 🎨 Constantes globales (colores base)
  static const Color primary = Color(0xFFFF944D);
  static const Color accent = Color(0xFFFFE7A0);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color inputFocus = primary;
  static const Color buttonForeground = Colors.white;
  static const Color buttonDisabled = Colors.grey;

  // 🟡 Promociones y botones
  static const Color promoYellow = Color(0xFFFFF0C2);
  static const Color promoButton = Color(0xFFFFE7A0);
  static const Color promoButtonIcon = Color(0xFFD19500);

  // ✅ Iconos, validaciones
  static const Color successCheck = Color(0xFF22C55E);
  static const Color iconBgLight = Color(0xFFF2FEE0);
  static const Color iconColorStrong = Color(0xFF167426);
}
