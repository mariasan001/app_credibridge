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
        color: isDark ? const Color(0xFFFF944D) : Colors.black,
        size: 24.sp,
      ),
      tooltip: 'Cambiar tema',
      onPressed: () {
        context.read<ThemeNotifier>().toggleTheme();
        final nuevoTema = isDark ? 'Modo claro activado' : 'Modo oscuro activado';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nuevoTema),
            duration: const Duration(milliseconds: 900),
          ),
        );
      },
    );
  }
}
