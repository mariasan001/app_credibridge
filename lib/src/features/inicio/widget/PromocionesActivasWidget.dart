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
    final fechaFin = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(promo.endDate);
    final fechaFormateada = DateFormat(
      "d 'de' MMMM 'del' yyyy",
      'es_MX',
    ).format(fechaFin);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.promoCardBackground(context),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Contenido
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header con icono y título
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor:AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.local_offer_outlined,
                          color: AppColors.primary,
                          size: 20.sp,
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
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Ofrecido por ${promo.lenderName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall(context).copyWith(
                                fontSize: 11.sp,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  /// Descripción
                  Text(
                    promo.promotionDesc,
                    style: AppTextStyles.promoBody(context).copyWith(
                      fontSize: 13.sp,
                      color: AppColors.textMuted(context),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  /// Beneficios
                  ...promo.benefits.map(
                    (benef) => Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
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
                                height: 1.4,
                                color: AppColors.textMuted(context),
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

            /// Footer con botón
            // Footer con estilo moderno
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.promoYellow.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18.r),
                  bottomRight: Radius.circular(18.r),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.promoYellow.withOpacity(0.4),
                    width: 0.8,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Etiqueta de vencimiento
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.sp,
                        color: AppColors.textMuted(context),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Vence: $fechaFormateada',
                        style: AppTextStyles.promoFooterDate(context).copyWith(
                          fontSize: 10.sp,
                          color: AppColors.textMuted(context),
                        ),
                      ),
                    ],
                  ),

                  // Botón moderno
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 400),
                    openBuilder:
                        (context, _) => PromocionDetallePage(promo: promo),
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    closedBuilder:
                        (context, openContainer) => GestureDetector(
                          onTap: openContainer,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Explorar',
                                  style: AppTextStyles.promoButtonText(
                                    context,
                                  ).copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16.sp,
                                  color: AppColors.primary,
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
