import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/page/directorio_page.dart';

class DescuentoCard extends StatelessWidget {
  final double? descuento;
  final User user;

  const DescuentoCard({super.key, required this.descuento, required this.user});

  @override
  Widget build(BuildContext context) {
    final textoDescuento = descuento == null
        ? 'Cargando...'
        : (descuento! > 0
            ? NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(descuento)
            : 'Sin descuento disponible');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Total de descuento disponible',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            textoDescuento,
            style: const TextStyle(
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
            children: [
              _DashboardAction(icon: Icons.search, label: 'Consultar'),
              _DashboardAction(icon: Icons.swap_horiz, label: 'Movimientos'),
              OpenContainer(
                
                transitionType: ContainerTransitionType.fadeThrough,
                closedElevation: 0,
                closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                closedColor: Colors.transparent,
                openBuilder: (context, _) => DirectorioPage(user: user),
                closedBuilder: (context, openContainer) => _DashboardAction(
                  icon: Icons.menu_book,
                  label: 'Directorio',
                  onTap: openContainer,
                  
                ),
              ),
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
  final VoidCallback? onTap;

  const _DashboardAction({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 28, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}