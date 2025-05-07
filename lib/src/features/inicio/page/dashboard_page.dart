import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  final User user;
  String obtenerNombreFormateado(String nombreCompleto) {
    final partes = nombreCompleto.trim().split(RegExp(r'\s+'));

    if (partes.length < 2) return nombreCompleto;

    final primerApellido =
        partes[0][0].toUpperCase() + partes[0].substring(1).toLowerCase();
    final primerNombre =
        partes.length > 2
            ? partes[2][0].toUpperCase() + partes[2].substring(1).toLowerCase()
            : partes[1][0].toUpperCase() + partes[1].substring(1).toLowerCase();

    return '$primerNombre $primerApellido';
  }

  String _capitalizar(String palabra) {
    if (palabra.isEmpty) return '';
    return palabra[0].toUpperCase() + palabra.substring(1).toLowerCase();
  }

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(user: user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido ${obtenerNombreFormateado(user.name)} 👋',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            const Text('Gestiona tu cuenta de manera rápida y sencilla.'),
            const SizedBox(height: 24),

            // Card de Descuento Disponible
            _buildDescuentoCard(),

            const SizedBox(height: 32),

            // Sección de promociones
            const Text(
              'Promociones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildPromocionCard(),

            const SizedBox(height: 32),

            // Botón para cerrar sesión
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  await SessionManager.clearToken();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  }
                },
                child: const Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescuentoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Total de descuento disponible',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            '\$10',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Se muestra el monto que puede descontarse de tu nómina.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _DashboardAction(icon: Icons.search, label: 'Consultar'),
              _DashboardAction(icon: Icons.swap_horiz, label: 'Movimientos'),
              _DashboardAction(icon: Icons.menu_book, label: 'Directorio'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromocionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¡Protege tu auto y ahorra! 🚗',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'En COORDINADOR NACIONAL DE SEGUROS, aprovecha esta oportunidad con tranquilidad. Por tiempo limitado, obtén 10% de descuento en tu seguro de auto.',
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('✅ Seguro amplio y económico'),
              Text('✅ Atención personalizada'),
              Text('✅ Sin deducible por pérdida total'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Expira el 26 de junio del 2025',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Chip(label: Text('Lo quiero ❤️'), backgroundColor: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DashboardAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
