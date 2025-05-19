import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'options_menu_items.dart';

class OptionsMenuOverlay {
  static OverlayEntry build({
    required BuildContext context,
    required Offset offset,
    required VoidCallback onClose,
    required User user,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return OverlayEntry(
      builder: (_) => Stack(
        children: [
          GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            right: 10,
            top: offset.dy + 48,
            child: Material(
              color: Colors.transparent,
              child: OptionsMenuItems(
                isDark: isDark,
                onClose: onClose,
                user: user,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
