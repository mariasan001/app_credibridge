import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class PromocionCardSkeleton extends StatelessWidget {
  const PromocionCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade700 : Colors.grey.shade200;
    final highlightColor = isDark ? Colors.grey.shade500 : Colors.grey.shade100;

    return FadeScaleTransition(
      animation: AlwaysStoppedAnimation(1.0), // Si quieres usar con AnimatedList, cambia esto
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.promoCardBackground(context),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.promoShadow(context),
              blurRadius: 6.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header con logo
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: baseColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 14.h, width: double.infinity, color: baseColor),
                              SizedBox(height: 6.h),
                              Container(height: 10.h, width: 120.w, color: baseColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    /// Descripción
                    Container(height: 12.h, width: double.infinity, color: baseColor),
                    SizedBox(height: 6.h),
                    Container(height: 12.h, width: double.infinity, color: baseColor),
                    SizedBox(height: 6.h),
                    Container(height: 12.h, width: 200.w, color: baseColor),
                    SizedBox(height: 16.h),

                    /// Beneficios fake
                    for (int i = 0; i < 3; i++) ...[
                      Row(
                        children: [
                          Icon(Icons.circle, size: 12.sp, color: baseColor),
                          SizedBox(width: 8.w),
                          Container(height: 10.h, width: 180.w, color: baseColor),
                        ],
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ],
                ),
              ),

              /// Footer decorativo
              Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.promoYellow,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14.r),
                    bottomRight: Radius.circular(14.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
