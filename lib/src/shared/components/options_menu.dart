import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/perfil/page/page_perfil.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:flutter/material.dart';

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
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              GestureDetector(
                onTap: _cerrarMenu,
                behavior: HitTestBehavior.translucent,
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                right: 16,
                top: offset.dy + renderBox.size.height + 6,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ajustes de perfil',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        OpenContainer(
                          transitionType:
                              ContainerTransitionType
                                  .fadeThrough, // o .fade o .sharedAxis
                          transitionDuration: const Duration(milliseconds: 500),
                          closedElevation: 0,
                          closedColor: Colors.transparent,
                          closedShape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          openBuilder:
                              (context, _) => PerfilPage(user: widget.user),
                          closedBuilder:
                              (context, openContainer) => ListTile(
                                leading: const Icon(Icons.person_outline),
                                title: const Text('Ver perfil'),
                                onTap: () {
                                  _cerrarMenu();
                                  openContainer(); // 👉 animación al abrir
                                },
                              ),
                        ),
                        const Divider(indent: 16, endIndent: 16, height: 0),
                        ListTile(
                          leading: const Icon(Icons.description_outlined),
                          title: const Text('Documentos'),
                          onTap: () {
                            _cerrarMenu();
                            // TODO: Navegar a Documentos
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Cerrar sesión'),
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
    return IconButton(
      key: _menuKey,
      icon: const Icon(Icons.grid_view_outlined, color: Colors.black),
      onPressed: _mostrarMenu,
    );
  }
}
