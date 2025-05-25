import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/page/directorio_page.dart';
import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';
import 'package:app_creditos/src/features/movimientos/page/page_movimientos.dart';
import 'package:app_creditos/src/features/simulasion/page/simulasion_page.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

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
            color: AppColors.promoShadow(context).withOpacity(0.08),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Título principal
          Text(
            'Límite de descuento en nómina',
            style: AppTextStyles.heading(context).copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 10.h),

          // Animación de conteo del monto
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: descuento!),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (_, value, __) {
              final partes = NumberFormat.currency(
                locale: 'es_MX',
                symbol: '',
                decimalDigits: 2,
              ).format(value).split('.');

              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${partes[0]}.',
                      style: AppTextStyles.heading(context).copyWith(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: partes[1],
                      style: AppTextStyles.heading(context).copyWith(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                    ),
                    TextSpan(
                      text: ' mx',
                      style: AppTextStyles.bodySmall(
                        context,
                      ).copyWith(fontSize: 18.sp, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 8.h),

          // Descripción auxiliar
          Text(
            'Este es el monto máximo que puede ser descontado de tu nómina.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(fontSize: 12.sp, color: AppColors.textMuted(context)),
          ),

          SizedBox(height: 20.h),

          // Accesos rápidos agrupados
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimatedAccess(
                  context: context,
                  icon: LineIcons.calculator,
                  label: 'Simular',
                  destination: SimulacionPage(user: user, descuento: descuento),
                ),
                _buildAnimatedAccess(
                  context: context,
                  icon: LineIcons.random,
                  label: 'Movimientos',
                  destination: PageMovimientos(user: user),
                ),
                _buildAnimatedAccess(
                  context: context,
                  icon: LineIcons.addressBook,
                  label: 'Directorio',
                  destination: DirectorioPage(user: user),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Acceso animado reutilizable con OpenContainer
  Widget _buildAnimatedAccess({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget destination,
  }) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      openElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      openBuilder: (_, __) => destination,
      closedBuilder: (context, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: _buildActionVisual(context: context, icon: icon, label: label),
        );
      },
    );
  }

  // Diseño base de cada botón de acceso
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
