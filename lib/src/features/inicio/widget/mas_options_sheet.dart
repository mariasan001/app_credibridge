import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/perfil/page/page_perfil.dart';
import 'package:app_creditos/src/shared/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MasOptionsSheet extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const MasOptionsSheet({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    void close() => Navigator.pop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTile(
            context,
            LineIcons.user,
            'Ver perfil',
            onTap: () {
              close();
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
            onTap: close, // Reemplaza con tu lógica real
          ),
          _buildTile(
            context,
            LineIcons.moon,
            'Modo oscuro',
            onTap: () {
              close();
              // Aquí puedes usar Provider, Bloc o similar para cambiar el modo
            },
          ),
          _buildTile(
            context,
            LineIcons.alternateSignOut,
            'Cerrar sesión',
            isLogout: true,
            onTap: () async {
              close(); // cerrar el bottom sheet
              await ApiService.logout(); // eliminar token
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ), // <-- tu login aquí
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  // Este método puede estar fuera o dentro del widget
  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String label, {
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : null),
      title: Text(label, style: TextStyle(color: isLogout ? Colors.red : null)),
      onTap: onTap,
    );
  }
}
