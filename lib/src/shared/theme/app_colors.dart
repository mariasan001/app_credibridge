import 'package:flutter/material.dart';

class AppColors {
  // 🌞🌚 Dependientes del tema

  static Color inputBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 219, 201, 201)
          : const Color(0xFFF6F6F6);

  static Color inputBackground1(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 26, 23, 23)
          : const Color.fromARGB(255, 241, 240, 240);

  static Color inputBackground2(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 26, 23, 23)
          : const Color.fromARGB(255, 255, 255, 255);
          
  static Color inputBackground3(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 26, 23, 23)
          : const Color.fromARGB(255, 247, 247, 247);

  static Color cardBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 18, 10, 1)
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

static Color textCar(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ?  const Color.fromARGB(255, 234, 221, 197)
        :  const Color(0xFF746343);

static Color cardtextfondo(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ?  const Color.fromARGB(255, 52, 205, 141)
        :   const Color.fromARGB(255, 18, 134, 86);



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
  static const Color cuotasColor = Color.fromARGB(255, 18, 134, 86);
}
