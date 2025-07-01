import 'package:flutter/material.dart';

class AppColors {
  // 🌞🌚 Dependientes del tema

  static Color inputBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFFF5F5F7)
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
          : const Color(0xFFF5F5F7);

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
          ? const Color.fromARGB(255, 234, 221, 197)
          : const Color.fromARGB(255, 61, 61, 61);

  static Color cardtextfondo(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 52, 205, 141)
          : const Color.fromARGB(255, 0, 0, 0);


  // este fodo es es para el fondo principal de la app
  static Color fondoPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 51, 51, 51)
          : const Color.fromARGB(255, 241, 241, 241);

  // es es el fododo superior de la app
  static Color fondoSeconds(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 27, 26, 26)
          : const Color.fromARGB(255, 253, 253, 253);

  // estes es el color de los textods, y dubitulos

  static Color textapp(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 197, 197, 197)
          : const Color.fromARGB(255, 93, 93, 93);

  // estas son las varianted de titlos   titlos dentro de la app
  static Color titleapp(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(255, 0, 0, 0);

  // secciones de como el seelctor de simulr,movimiento y directorio

  static Color selectoption(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(255, 0, 0, 0);


// seccion de del nav ingerior 

  static Color containernav(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 26, 25, 25)
          : const Color.fromARGB(255, 255, 255, 255);


  static Color optionseelct(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 55, 54, 54)
          : const Color.fromARGB(255, 0, 0, 0);


  static Color textbtn(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(255, 224, 224, 224);


  static Color iconsbton(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 226, 226, 226)
          : const Color.fromARGB(255, 36, 36, 36);












  // 🎨 Constantes globales (colores base)
  static const Color primary = Color.fromARGB(255, 0, 0, 0);
  static const Color second = Color.fromARGB(255, 238, 149, 16);
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
