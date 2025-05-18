import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/page/simulasion_page.dart';
import 'package:app_creditos/src/features/directorio/page/directorio_page.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';

class DescuentoCard extends StatelessWidget {
  final double? descuento;
  final User user;

  const DescuentoCard({super.key, required this.descuento, required this.user});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    if (descuento == null) return const DescuentoCardSkeleton();

    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 12),
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
            style: AppTextStyles.heading(context).copyWith(
              fontSize: isTablet ? 18 : 16,
            ),
          ),
          const SizedBox(height: 11),

          /// Monto animado
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: descuento!),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Text(
                NumberFormat.currency(
                  locale: 'es_MX',
                  symbol: '\$',
                ).format(value),
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: isTablet ? 48 : 50,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          Text(
            'Se muestra el monto que puede descontarse de tu nómina.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontSize: isTablet ? 14 : 10,
            ),
          ),

          const SizedBox(height: 20),

          /// Acciones responsivas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFCF8F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.spaceEvenly,
              children: _buildDashboardActions(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDashboardActions(BuildContext context) {
    return [
      OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        closedColor: Colors.white,
        openBuilder: (context, _) =>
            SimulacionPage(user: user, descuento: descuento!),
        closedBuilder: (context, openContainer) => _DashboardAction(
          icon: Icons.timeline_outlined,
          label: 'Simular',
          onTap: openContainer,
        ),
      ),
      _DashboardAction(
        icon: Icons.swap_horiz,
        label: 'Movimientos',
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Función "Movimientos" aún no disponible'),
            ),
          );
        },
      ),
      OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        closedColor: Colors.white,
        openBuilder: (context, _) => DirectorioPage(user: user),
        closedBuilder: (context, openContainer) => _DashboardAction(
          icon: Icons.book_outlined,
          label: 'Directorio',
          onTap: openContainer,
        ),
      ),
    ];
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
        constraints: const BoxConstraints(minWidth: 90, maxWidth: 140),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 25, color: Colors.black87),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
