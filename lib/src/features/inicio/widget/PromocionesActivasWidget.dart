import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/inicio/page/romocion_detalle_page.dart';
import '../model/model_promociones.dart';

class PromocionCardVisual extends StatelessWidget {
  final Promotion promo;

  const PromocionCardVisual({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    final fechaFin = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(promo.endDate);
    final fechaFormateada = DateFormat(
      "d 'de' MMMM 'del' yyyy",
      'es_MX',
    ).format(fechaFin);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isTablet ? 16 : 17),
        decoration: BoxDecoration(
          color: AppColors.promoCardBackground(context),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.promoShadow(context),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔝 Contenido superior
            Padding(
              padding: EdgeInsets.all(isTablet ? 20 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🧠 Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: isTablet ? 22 : 18,
                        backgroundColor: AppColors.iconBgLight,
                        child: const Icon(
                          Icons.doorbell_outlined,
                          color: AppColors.iconColorStrong,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promo.promotionTitle,
                              style: AppTextStyles.promoTitle(context).copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: isTablet ? 18 : 16,
                                color: AppColors.text(context),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Financiera: ${promo.lenderName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.promoBold(context).copyWith(
                                fontSize: isTablet ? 14 : 10,
                                fontWeight: FontWeight.w100,
                                color: AppColors.textMuted(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// 📝 Descripción
                  Text(
                    promo.promotionDesc,
                    style: AppTextStyles.promoBody(context).copyWith(
                      fontSize: isTablet ? 14 : 12,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// ✅ Lista de beneficios
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        promo.benefits.map((benef) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.successCheck,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    benef,
                                    style: AppTextStyles.promoListText(
                                      context,
                                    ).copyWith(
                                      fontSize: isTablet ? 14 : 12,
                                      color: Colors.black54,
                                      height: 1.4,
                                    ),
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

            /// 📅 Footer con botón
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.promoYellow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Expira el $fechaFormateada',
                      style: AppTextStyles.promoFooterDate(
                        context,
                      ).copyWith(fontSize: isTablet ? 13 : 12),
                    ),
                  ),
                  OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 500),
                    closedElevation: 0,
                    openBuilder:
                        (context, _) => PromocionDetallePage(promo: promo),
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    closedColor: AppColors.promoButton,
                    closedBuilder:
                        (context, openContainer) => InkWell(
                          onTap: openContainer,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 16 : 12,
                              vertical: isTablet ? 10 : 8,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.favorite_border,
                                  color: AppColors.promoButtonIcon,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Lo quiero',
                                  style: AppTextStyles.promoButtonText(
                                    context,
                                  ).copyWith(
                                    color: const Color.fromARGB(
                                      255,
                                      142,
                                      113,
                                      10,
                                    ),
                                    fontSize: isTablet ? 14 : 13,
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
