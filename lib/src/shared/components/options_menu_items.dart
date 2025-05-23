import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/solicitudes/page/page_solicitudes.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
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
    onClose();
    await SessionManager.clearToken();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
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
            _buildHeader(),
            _buildVerPerfil(context),
            _buildDivider(),
            _buildDocumentos(),
            _buildQuejas(),
            _buildSolicitudes(context),
            _buildCerrarSesion(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
  );

  Widget _buildVerPerfil(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 350),
      closedElevation: 0,
      closedColor: Colors.transparent,
      closedShape: const RoundedRectangleBorder(),
      openBuilder: (_, __) => PerfilPage(user: user),
      closedBuilder:
          (_, openContainer) => InkWell(
            onTap: () {
              onClose();
              openContainer();
            },
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              leading: Icon(
                Icons.person_outline,
                color: isDark ? Colors.white : null,
              ),
              title: Text(
                'Ver perfil',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white : null,
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildSolicitudes(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 350),
      closedElevation: 0,
      closedColor: Colors.transparent,
      closedShape: const RoundedRectangleBorder(),
      openBuilder: (_, __) => PageSolicitudes(user: user),
      closedBuilder:
          (_, openContainer) => InkWell(
            onTap: () {
              onClose();
              openContainer();
            },
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              leading: Icon(
                Icons.attach_money_rounded,
                color: isDark ? Colors.white : null,
              ),
              title: Text(
                'Solicitudes',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white : null,
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildDocumentos() => InkWell(
    onTap: onClose,
    borderRadius: BorderRadius.circular(12),
    child: ListTile(
      leading: Icon(
        Icons.description_outlined,
        color: isDark ? Colors.white : null,
      ),
      title: Text(
        'Documentos',
        style: TextStyle(fontSize: 13, color: isDark ? Colors.white : null),
      ),
    ),
  );
  Widget _buildQuejas() => InkWell(
    onTap: onClose,
    borderRadius: BorderRadius.circular(12),
    child: ListTile(
      leading: Icon(
        Icons.error_outline_sharp,
        color: isDark ? Colors.white : null,
      ),
      title: Text(
        'Quejas y Aclaraciones',
        style: TextStyle(fontSize: 13, color: isDark ? Colors.white : null),
      ),
    ),
  );

  Widget _buildCerrarSesion(BuildContext context) => InkWell(
    onTap: () => _logout(context),
    borderRadius: BorderRadius.circular(12),
    child: ListTile(
      leading: Icon(Icons.logout, color: isDark ? Colors.white : null),
      title: Text(
        'Cerrar sesión',
        style: TextStyle(fontSize: 13, color: isDark ? Colors.white : null),
      ),
    ),
  );

  Widget _buildDivider() => Divider(
    height: 0,
    indent: 12,
    endIndent: 12,
    color: isDark ? Colors.white24 : Colors.black12,
  );
}
