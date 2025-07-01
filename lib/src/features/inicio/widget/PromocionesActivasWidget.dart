import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:app_creditos/src/features/inicio/page/romocion_detalle_page.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import '../model/model_promociones.dart';

class PromocionCardCarrusel extends StatelessWidget {
  final Promotion promo;
  const PromocionCardCarrusel({super.key, required this.promo});

  List<List<Color>> getGradientes() {
    return [
      [Color.fromARGB(255, 21, 84, 201), Color.fromARGB(255, 16, 86, 206)], // Azul profesional
      [Color.fromARGB(255, 186, 93, 72), Color.fromARGB(255, 224, 86, 48)], // Púrpura oscuro + azul petróleo
      [Color.fromARGB(255, 232, 220, 49), Color.fromARGB(255, 232, 220, 49)], // Azul grisáceo moderno
      [Color.fromARGB(255, 24, 155, 13), Color.fromARGB(255, 33, 182, 19)], // Gris grafito con estilo
      [Color.fromARGB(255, 38, 15, 39), Color.fromARGB(255, 67, 32, 66)], // Verde oscuro sobrio
    ];
  }


List<IconData> getIconos() {
  return [
    RemixIcons.gift_2_line,
    RemixIcons.star_smile_line,
    RemixIcons.award_line,
    RemixIcons.discount_percent_line,
    RemixIcons.hand_heart_line,
    RemixIcons.shopping_bag_3_line,
    RemixIcons.fire_line,
    RemixIcons.coins_line,
  ];
}
  @override
  Widget build(BuildContext context) {
    final fechaFin = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(promo.endDate);
    final fechaFormateada = DateFormat("d MMM", 'es_MX').format(fechaFin);
    final gradient =
        getGradientes()[promo.promotionTitle.hashCode % getGradientes().length];
    final iconos = getIconos();
    final iconoSeleccionado =
        iconos[promo.promotionTitle.hashCode % iconos.length];

    return Container(
      width: 265.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(2, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícono cuadrado con borde
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(iconoSeleccionado, color: const Color.fromARGB(255, 255, 255, 255), size: 26.sp),
          ),

          SizedBox(height: 14.h),

          // Título fuerte
          Text(
            promo.promotionTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.promoTitle(context).copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 8.h),

          // Lender
          Text(
            'De ${promo.lenderName}',
            style: TextStyle(fontSize: 12.sp, color: Colors.white70),
          ),

          const Spacer(),

          // Vence + botón pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vence: $fechaFormateada',
                style: TextStyle(fontSize: 11.sp, color: Colors.white70),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PromocionDetallePage(promo: promo),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Ver más',
                        style: TextStyle(
                          color: gradient[0],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14.sp,
                        color: gradient[0],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
