import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class DescuentoCard extends StatelessWidget {
  final double? descuento;

  const DescuentoCard({super.key, required this.descuento});

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
              _DashboardAction(
                icon: Icons.menu_book,
                label: 'Directorio',
                onTap: () {
                  Navigator.pushNamed(context, '/directorio');
                },
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
