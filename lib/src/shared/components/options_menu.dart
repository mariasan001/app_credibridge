
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/perfil/page/page_perfil.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';

class OptionsMenuOverlay {
  static OverlayEntry build({
    required BuildContext context,
    required Offset offset,
    required VoidCallback onClose,
    required User user,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
            top: offset.dy + 44,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ajustes de perfil',
                          style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      transitionDuration: const Duration(milliseconds: 500),
                      closedElevation: 0,
                      closedColor: Colors.transparent,
                      closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      openBuilder: (context, _) => PerfilPage(user: user),
                      closedBuilder: (context, openContainer) => ListTile(
                        leading: Icon(Icons.person_outline, color: isDark ? Colors.white : null),
                        title: Text('Ver perfil', style: TextStyle(color: isDark ? Colors.white : null, fontSize: 13)),
                        onTap: () {
                          onClose();
                          openContainer();
                        },
                      ),
                    ),
                    Divider(color: isDark ? Colors.white24 : Colors.black12),
                    ListTile(
                      leading: Icon(Icons.description_outlined, color: isDark ? Colors.white : null),
                      title: Text('Documentos', style: TextStyle(color: isDark ? Colors.white : null, fontSize: 13)),
                      onTap: onClose,
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: isDark ? Colors.white : null),
                      title: Text('Cerrar sesión', style: TextStyle(color: isDark ? Colors.white : null, fontSize: 13)),
                      onTap: () async {
                        onClose();
                        await SessionManager.clearToken();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        }
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
  }
}
