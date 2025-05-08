import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/page/directorio_page.dart';

class DescuentoCard extends StatelessWidget {
  final double? descuento;
  final User user;

  const DescuentoCard({super.key, required this.descuento, required this.user});

  @override
  Widget build(BuildContext context) {
    if (descuento == null) {
      return const DescuentoCardSkeleton();
    }

    final textoDescuento = descuento! > 0
        ? NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(descuento)
        : 'Sin descuento disponible';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          Text(
            'Total de descuento disponible',
            style: AppTextStyles.heading(context).copyWith(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Text(
            textoDescuento,
            style: AppTextStyles.heading(context).copyWith(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Se muestra el monto que puede descontarse de tu nómina.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(context),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFCF8F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DashboardAction(
                  icon: Icons.bar_chart,
                  label: 'consultar',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Función "Consultar" aún no disponible')),
                    );
                  },
                ),
                _DashboardAction(
                  icon: Icons.swap_horiz,
                  label: 'Movimientos',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Función "Movimientos" aún no disponible')),
                    );
                  },
                ),
                OpenContainer(
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedElevation: 0,
                  closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  closedColor: Colors.white,
                  openBuilder: (context, _) => DirectorioPage(user: user),
                  closedBuilder: (context, openContainer) => _DashboardAction(
                    icon: Icons.menu_book,
                    label: 'Directorio',
                    onTap: openContainer,
                  ),
                ),
              ],
            ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 26, color: Colors.black87),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
