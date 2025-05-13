import 'package:flutter/material.dart';

class OptionsMenuButton extends StatefulWidget {
  const OptionsMenuButton({super.key});

  @override
  State<OptionsMenuButton> createState() => _OptionsMenuButtonState();
}

class _OptionsMenuButtonState extends State<OptionsMenuButton> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _mostrarMenu() {
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Fondo para cerrar al tocar fuera
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),

          // Menú flotante
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
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Ver perfil'),
                      onTap: () {
                        _cerrarMenu();
                        // TODO: Navegar a Perfil
                      },
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
                      onTap: () {
                        _cerrarMenu();
                        // TODO: Lógica de logout
                      },
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: _menuKey,
      icon: const Icon(Icons.grid_view_outlined, color: Colors.black),
      onPressed: _mostrarMenu,
    );
  }
}
