import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.promoCardBackground(context),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🎞️ Animación Lottie
              SizedBox(
                width: 120.h,
                child: Lottie.asset(
                  'assets/img/ani_promocion.json',
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                'No hay promociones activas',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.h),
              Text(
                'Vuelve pronto para descubrir nuevas oportunidades exclusivas.',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.textMuted(context),
                ),
                textAlign: TextAlign.center,
              ),
              if (onAccionNueva != null) ...[
                SizedBox(height: 24.h),
                OutlinedButton.icon(
                  onPressed: onAccionNueva,
                  icon: Icon(Icons.refresh, size: 18.sp),
                  label: Text(
                    'Volver a intentar',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.text(context),
                    side: BorderSide(
                      color: isDark ? Colors.white24 : const Color(0xFFE2E8F0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
