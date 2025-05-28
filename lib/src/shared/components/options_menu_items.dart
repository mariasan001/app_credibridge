import 'package:app_creditos/src/features/quejas-solicitudes/page/historial_solicitudes_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:app_creditos/src/features/solicitudes/page/page_solicitudes.dart';
import 'package:app_creditos/src/features/perfil/page/page_perfil.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';

class OptionsMenuItems extends StatelessWidget {
  final bool isDark;
  final VoidCallback onClose;
  final User user;

  const OptionsMenuItems({
    super.key,
    required this.isDark,
    required this.onClose,
    required this.user,
  });

  Future<void> _logout(BuildContext context) async {
    print('➡️ Clic en cerrar sesión');

    final tokenAntes = await SessionManager.getToken();
    print('🔍 Token antes de limpiar: $tokenAntes');

    await SessionManager.clearToken();

    final tokenDespues = await SessionManager.getToken();
    print('🧹 Token después de limpiar: $tokenDespues');

    await Future.delayed(const Duration(milliseconds: 100));

    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTile(
              context,
              LineIcons.user,
              'Ver perfil',
              onTap: () {
                onClose();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PerfilPage(user: user)),
                );
              },
            ),
            _buildTile(
              context,
              LineIcons.fileAlt,
              'Documentos',
              onTap: onClose,
            ),
            _buildTile(
              context,
              LineIcons.exclamationCircle,
              'Quejas y Aclaraciones',
              onTap: () {
                onClose();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistorialSolicitudesPage(user: user),
                  ),
                );
              },
            ),
            _buildTile(
              context,
              LineIcons.creditCard,
              'Solicitudes',
              onTap: () {
                onClose();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PageSolicitudes(user: user),
                  ),
                );
              },
            ),
            _buildTile(
              context,
              LineIcons.alternateSignOut,
              'Cerrar sesión',
              isLogout: true,
              onTap: () async {
                await _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title, {
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color:
                  isLogout
                      ? Colors.red
                      : (isDark ? Colors.white : Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color:
                      isLogout
                          ? Colors.red
                          : (isDark ? Colors.white : Colors.black87),
                ),
              ),
            ),
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: isDark ? Colors.white30 : Colors.black26,
              ),
          ],
        ),
      ),
    );
  }
}
