import 'package:flutter/material.dart';

class AppColors {
  // 🌞🌚 Dependientes del tema
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

  static Color promoCardBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2A2A2A)
          : Colors.white;

  static Color promoShadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black26
          : const Color(0x11000000);

  // 🎨 Constantes (no cambian)
  static const Color primary = Color(0xFFFF944D);
  static const Color inputFocus = primary;
  static const Color buttonForeground = Colors.white;
  static const Color buttonDisabled = Colors.grey;

  static const Color promoBackground = Color.fromARGB(255, 255, 255, 255);
  static const Color promoYellow = Color(0xFFFFF0C2);
  static const Color promoButton = Color(0xFFFFE7A0);
  static const Color promoButtonIcon = Color(0xFFD19500);
  static const Color successCheck = Color(0xFF22C55E);

  static const Color iconBgLight = Color.fromARGB(255, 242, 254, 224);
  static const Color iconColorStrong = Color.fromARGB(255, 22, 116, 38);
}
