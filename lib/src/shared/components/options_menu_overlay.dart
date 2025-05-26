import 'dart:ui';
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
          // Fondo difuminado + dismiss
          GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.translucent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),

          // Menú en la parte inferior ocupando todo el ancho
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 2,
                ),
  
                child: OptionsMenuItems(
                  isDark: isDark,
                  onClose: onClose,
                  user: user,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
