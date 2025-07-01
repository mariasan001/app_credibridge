import 'package:app_creditos/src/features/inicio/widget/mas_options_sheet.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';

class OptionsMenuButton extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const OptionsMenuButton({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color orange = const Color(0xFFFF8C00);

    return IconButton(
      icon: Icon(
        Icons.grid_view_outlined,
        color: isDark ? orange : Colors.black,
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (_) => MasOptionsSheet(
            user: user,
            onLogout: onLogout,
          ),
        );
      },
    );
  }
}
