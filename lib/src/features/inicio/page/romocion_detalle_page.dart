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
        elevation: 0.8,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.text(context)),
        title: Text(
          promo.promotionTitle,
          style: AppTextStyles.promoTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título + ícono institucional
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.campaign_outlined,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          promo.promotionTitle,
                          style: AppTextStyles.promoTitle(
                            context,
                          ).copyWith(fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Financiera
                  Text(
                    'Financiera',
                    style: AppTextStyles.promoBold(
                      context,
                    ).copyWith(fontSize: 15.sp, color: AppColors.accent),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    promo.lenderName,
                    style: AppTextStyles.bodySmall(
                      context,
                    ).copyWith(fontSize: 14.sp),
                  ),
                  Divider(height: 30.h),

                  // Descripción
                  Text(
                    'Descripción',
                    style: AppTextStyles.promoBold(
                      context,
                    ).copyWith(fontSize: 15.sp, color: AppColors.accent),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    promo.promotionDesc,
                    style: AppTextStyles.promoBody(
                      context,
                    ).copyWith(fontSize: 14.sp),
                  ),
                  Divider(height: 30.h),

                  // Beneficios
                  Text(
                    'Beneficios',
                    style: AppTextStyles.promoBold(
                      context,
                    ).copyWith(fontSize: 15.sp, color: AppColors.accent),
                  ),
                  SizedBox(height: 12.h),
                  Column(
                    children:
                        promo.benefits.map((benefit) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: AppColors.successCheck,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    benefit,
                                    style: AppTextStyles.promoListText(
                                      context,
                                    ).copyWith(fontSize: 14.sp),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
  
    );
  }
}
