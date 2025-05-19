import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class SinPromocionesWidget extends StatelessWidget {
  final VoidCallback? onAccionNueva;

  const SinPromocionesWidget({super.key, this.onAccionNueva});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: FadeScaleTransition(
        animation: AlwaysStoppedAnimation(1.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 30.h),
          decoration: BoxDecoration(
            color: AppColors.promoCardBackground(context),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.promoShadow(context),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icono Emoji
              Text(
                '🛍️',
                style: TextStyle(fontSize: 48.sp),
              ),

              SizedBox(height: 20.h),

              // Título
              Text(
                'No hay promociones activas',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text(context),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),

              // Subtítulo
              Text(
                'Vuelve pronto para descubrir nuevas oportunidades exclusivas.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textMuted(context),
                ),
                textAlign: TextAlign.center,
              ),

              // Botón de recarga si aplica
              if (onAccionNueva != null) ...[
                SizedBox(height: 24.h),
                OutlinedButton.icon(
                  onPressed: onAccionNueva,
                  icon: Icon(Icons.refresh, size: 18.sp),
                  label: Text(
                    'Volver a intentar',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.text(context),
                    side: BorderSide(
                      color: isDark ? Colors.white24 : const Color(0xFFE2E8F0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
