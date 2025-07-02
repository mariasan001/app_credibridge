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

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          // Título
          Text(
            'Límite de descuento  ',
            style: AppTextStyles.heading(
              context,
            ).copyWith(fontSize: 14.sp, color: AppColors.textapp(context)),
          ),
          SizedBox(height: 10.h),

          // Animación del monto
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
                      style: TextStyle(
                        fontSize: 68.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: partes[1],
                     style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 178, 163, 4),
                      ),
                    ),
                    TextSpan(
                      text: ' mx',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontSize: 18.sp,
                        color: const Color.fromARGB(255, 172, 161, 8),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 8.h),

          // Descripción
          Text(
            'Este es el monto máximo que puede ser descontado de tu nómina.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(
              context,
            ).copyWith(fontSize: 11.sp, color: AppColors.textMuted(context)),
          ),

          SizedBox(height: 20.h),

          // Botones de acción (estilo redondo e inspirado)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color:
                  isDark
                      ? const Color.fromARGB(255, 39, 39, 39)
                      : const Color.fromARGB(255, 243, 243, 243),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimatedAccess(
                  context: context,
                  icon: LineIcons.wallet,
                  label: 'Simular',
                  destination: SimulacionPage(user: user, descuento: descuento),
                ),
                _buildAnimatedAccess(
                  context: context,
                  icon: LineIcons.history, // Más claro para "Movimientos"
                  label: 'Movimientos',
                  destination: PageMovimientos(user: user),
                ),
                _buildAnimatedAccess(
                  context: context,
                  icon:
                      LineIcons.users, // Más cálido y social para "Directorio"
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

  // Acceso con animación
  Widget _buildAnimatedAccess({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget destination,
    bool isActive = false,
  }) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      openElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.r),
      ),
      openBuilder: (_, __) => destination,
      closedBuilder: (context, openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: _buildActionVisual(
            context: context,
            icon: icon,
            label: label,
            isActive: isActive,
          ),
        );
      },
    );
  }

  // Diseño visual de cada botón
  Widget _buildActionVisual({
    required BuildContext context,
    required IconData icon,
    required String label,
    bool isActive = false,
  }) {
    final activeColor = AppColors.selectoption(context);

    return Container(
      constraints: BoxConstraints(minWidth: 90.w, maxWidth: 120.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color:
            isActive
                ? activeColor.withOpacity(0.15)
                : AppColors.promoCardBackground(context),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 25.sp,
            color: isActive ? activeColor : AppColors.text(context),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
              color: isActive ? activeColor : AppColors.text(context),
            ),
          ),
        ],
      ),
    );
  }
}
