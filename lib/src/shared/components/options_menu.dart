import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/perfil/page/page_perfil.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';

class OptionsMenuButton extends StatefulWidget {
  final User user;

  const OptionsMenuButton({super.key, required this.user});

  @override
  State<OptionsMenuButton> createState() => _OptionsMenuButtonState();
}

class _OptionsMenuButtonState extends State<OptionsMenuButton> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _mostrarMenu() {
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset       = renderBox.localToGlobal(Offset.zero);

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _cerrarMenu,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            right: 10,
            top: offset.dy + renderBox.size.height + 4,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 260,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ajustes de perfil',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white60 : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      transitionDuration: const Duration(milliseconds: 500),
                      closedElevation: 0,
                      closedColor: Colors.transparent,
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      openBuilder: (context, _) => PerfilPage(user: widget.user),
                      closedBuilder: (context, openContainer) => ListTile(
                        leading: Icon(Icons.person_outline, color: isDark ? Colors.white : null),
                        title: Text(
                          'Ver perfil',
                          style: TextStyle(color: isDark ? Colors.white : null , fontSize: 13,),
                        ),
                        onTap: () {
                          _cerrarMenu();
                          openContainer();
                        },
                      ),
                    ),
                    Divider(
                      indent: 1,
                      endIndent: 12,
                      height: 0,
                      color: isDark ? Colors.white24 : Colors.black12,
                    ),
                    ListTile(
                      leading: Icon(Icons.description_outlined, color: isDark ? Colors.white : null),
                      title: Text(
                        'Documentos',
                        style: TextStyle(color: isDark ? Colors.white : null, fontSize: 13,),
                      ),
                      onTap: () {
                        _cerrarMenu();
                        // TODO: Navegar a Documentos
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: isDark ? Colors.white : null),
                      title: Text(
                        'Cerrar sesión',
                        style: TextStyle(color: isDark ? Colors.white : null, fontSize: 13,),
                      ),
                      onTap: _handleLogout,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _cerrarMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> _handleLogout() async {
    _cerrarMenu();
    await SessionManager.clearToken();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      key: _menuKey,
      icon: Icon(Icons.grid_view_outlined, color: isDark ? Colors.white : Colors.black),
      onPressed: _mostrarMenu,
    );
  }
}
