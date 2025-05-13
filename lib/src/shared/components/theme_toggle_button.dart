import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      ),
      onPressed: () => context.read<ThemeNotifier>().toggleTheme(),
    );
  }
}
