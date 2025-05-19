import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'options_menu_overlay.dart';

class OptionsMenuButton extends StatefulWidget {
  final User user;
  const OptionsMenuButton({super.key, required this.user});

  @override
  State<OptionsMenuButton> createState() => _OptionsMenuButtonState();
}

class _OptionsMenuButtonState extends State<OptionsMenuButton> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showMenu() {
    final RenderBox box = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);

    _overlayEntry = OptionsMenuOverlay.build(
      context: context,
      offset: offset,
      onClose: _closeMenu,
      user: widget.user,
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color orange = const Color(0xFFFF8C00);

    return IconButton(
      key: _menuKey,
      icon: Icon(
        Icons.grid_view_outlined,
        color: isDark ? orange : const Color.fromARGB(255, 0, 0, 0),
      ),
      onPressed: _showMenu,
    );
  }
}
