import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class PromocionDetallePage extends StatelessWidget {
  final Promotion promo;

  const PromocionDetallePage({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: AppColors.text(context)),
        title: Text(
          promo.promotionTitle,
          style: AppTextStyles.promoTitle(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financiera:',
              style: AppTextStyles.promoBold(context).copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              promo.lenderName,
              style: AppTextStyles.bodySmall(context).copyWith(fontSize: 13.sp),
            ),

            SizedBox(height: 16.h),

            Text(
              'Descripción:',
              style: AppTextStyles.promoBold(context).copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              promo.promotionDesc,
              style: AppTextStyles.promoBody(context).copyWith(fontSize: 13.sp),
            ),

            SizedBox(height: 16.h),

            Text(
              'Beneficios:',
              style: AppTextStyles.promoBold(context).copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),

            ...promo.benefits.map(
              (benefit) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18, color: AppColors.successCheck),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        benefit,
                        style: AppTextStyles.promoListText(context).copyWith(fontSize: 13.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
