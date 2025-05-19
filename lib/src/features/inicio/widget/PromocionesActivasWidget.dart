import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/inicio/page/romocion_detalle_page.dart';
import '../model/model_promociones.dart';

class PromocionCardVisual extends StatelessWidget {
  final Promotion promo;

  const PromocionCardVisual({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fechaFin = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(promo.endDate);
    final fechaFormateada = DateFormat(
      "d 'de' MMMM 'del' yyyy",
      'es_MX',
    ).format(fechaFin);

    return Padding(
      padding: EdgeInsets.all(8.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Contenido Principal
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.iconBgLight,
                        child: const Icon(
                          Icons.doorbell_outlined,
                          color: AppColors.iconColorStrong,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promo.promotionTitle,
                              style: AppTextStyles.promoTitle(context).copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: AppColors.text(context),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Financiera: ${promo.lenderName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.promoBold(context).copyWith(
                                fontSize: 12.sp,
                                color: AppColors.textMuted(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  /// Descripción
                  Text(
                    promo.promotionDesc,
                    style: AppTextStyles.promoBody(context).copyWith(
                      fontSize: 13.sp,
                      color: AppColors.textMuted(context),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  /// Beneficios
                  ...promo.benefits.map(
                    (benef) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.successCheck,
                            size: 18.sp,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              benef,
                              style: AppTextStyles.promoListText(
                                context,
                              ).copyWith(
                                fontSize: 12.5.sp,
                                color: AppColors.textMuted(context),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Footer
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.promoYellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14.r),
                  bottomRight: Radius.circular(14.r),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Expira el $fechaFormateada',
                      style: AppTextStyles.promoFooterDate(context).copyWith(
                        fontSize: 12.sp,
                        color:
                            Colors
                                .black, // ✅ Forzar negro para que siempre se vea sobre promoYellow
                      ),
                    ),
                  ),
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 400),
                    openBuilder:
                        (context, _) => PromocionDetallePage(promo: promo),
                    closedColor: AppColors.promoButton,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    closedElevation: 0,
                    closedBuilder:
                        (context, openContainer) => InkWell(
                          onTap: openContainer,
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: AppColors.promoButtonIcon,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Lo quiero',
                                  style: AppTextStyles.promoButtonText(
                                    context,
                                  ).copyWith(
                                    color: AppColors.promoButtonIcon,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
