import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/movimientos/page/page_movimientos.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    if (descuento == null) return const DescuentoCardSkeleton();

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.promoCardBackground(context),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.promoShadow(context),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total de descuento disponible',
            style: AppTextStyles.heading(context).copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 10.h),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: descuento!),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (_, value, __) {
              return Text(
                NumberFormat.currency(
                  locale: 'es_MX',
                  symbol: '\$',
                ).format(value),
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              );
            },
          ),
          SizedBox(height: 8.h),
          Text(
            'Se muestra el monto que puede descontarse de tu nómina.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(fontSize: 12.sp, color: AppColors.textMuted(context)),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSimularAnimated(context),
                _buildActionContainer(
                  context: context,
                  icon: Icons.swap_horiz,
                  label: 'Movimientos',
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PageMovimientos(user: user),
                        ),
                      ),
                ),

                _buildActionContainer(
                  context: context,
                  icon: Icons.book_outlined,
                  label: 'Directorio',
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DirectorioPage(user: user),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔁 Animación con OpenContainer SOLO para "Simular"
  Widget _buildSimularAnimated(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      openElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      openBuilder: (_, __) => SimulacionPage(user: user, descuento: descuento,),
      closedBuilder: (context, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: _buildActionVisual(
            context: context,
            icon: Icons.timeline_outlined,
            label: 'Simular',
          ),
        );
      },
    );
  }

  /// 🎯 Contenedor visual reutilizable
  Widget _buildActionContainer({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _buildActionVisual(context: context, icon: icon, label: label),
    );
  }

  /// 🎨 Diseño interno
  Widget _buildActionVisual({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return Container(
      constraints: BoxConstraints(minWidth: 90.w, maxWidth: 120.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.promoCardBackground(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.promoShadow(context),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 25.sp, color: AppColors.text(context)),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
              color: AppColors.text(context),
            ),
          ),
        ],
      ),
    );
  }
}
