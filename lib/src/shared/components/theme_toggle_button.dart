import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/theme_notifier.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeNotifier>().isDark;

    return IconButton(
      icon: Icon(
        isDark ? Icons.wb_sunny_outlined : Icons.bedtime_outlined,
        color: Colors.black,
        size: 24.sp, // Escalado responsivo
      ),
      tooltip: 'Cambiar tema', // Mejora accesibilidad
      onPressed: () {
        context.read<ThemeNotifier>().toggleTheme();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isDark ? 'Modo claro activado' : 'Modo oscuro activado',
            ),
            duration: const Duration(milliseconds: 900),
          ),
        );
      },
    );
  }
}
