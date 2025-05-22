import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/simulasion/page/solicitar_credito.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadoSimulacionCard extends StatelessWidget {
  final SimulacionResult result;
  final bool isTopOption;
  final int? ranking;
  final User user;
  final SolicitudCreditoData solicitud;

  const ResultadoSimulacionCard({
    super.key,
    required this.result,
    required this.user,
    required this.solicitud,
    this.isTopOption = false,
    this.ranking,
  });

  static final formatCurrency = NumberFormat.currency(
    locale: 'es_MX',
    symbol: '\$',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    final labelFontSize = 11.sp;
    final valueFontSize = 15.sp;

    final backgroundColor = AppColors.cardBackground(context);
    final borderColor =
        isTopOption
            ? AppColors.primary
            : Theme.of(context).brightness == Brightness.dark
            ? Colors.white12
            : Colors.grey.shade300;

    final icon =
        isTopOption ? Icons.emoji_events_outlined : Icons.account_balance;
    final iconColor =
        isTopOption ? AppColors.iconColorStrong : AppColors.primary;

    final bool excedeDescuento =
        solicitud.tipoSimulacion?.id == 1 &&
        solicitud.descuento != null &&
        result.capital > solicitud.descuento!;

    final buttonColor =
        excedeDescuento
            ? Colors.red
            : (isTopOption ? AppColors.iconColorStrong : AppColors.primary);

    final String capitalLabel =
        solicitud.tipoSimulacion?.id == 1 ? 'Descuento' : 'Crédito';

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTopOption)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.iconColorStrong,
                    size: 20.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Mejor opción para ti',
                    style: AppTextStyles.titleheader(
                      context,
                    ).copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ),

          // Row principal
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.lenderName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.promoBold(
                        context,
                      ).copyWith(fontSize: valueFontSize),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      result.serviceTypeDesc.toUpperCase(),
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontSize: labelFontSize,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[400]
                                : Colors.grey[600],
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),

              // Botón
              OpenContainer(
                transitionType:
                    ContainerTransitionType.fadeThrough, 
                transitionDuration: const Duration(milliseconds: 350),
                openBuilder: (context, _) {
                  solicitud
                    ..tipoSimulacion = solicitud.tipoSimulacion
                    ..monto = solicitud.monto
                    ..plazo = solicitud.plazo
                    ..tasaAnual = result.effectiveAnnualRate
                    ..tasaPorPeriodo = result.effectivePeriodRate
                    ..lenderId = result.lenderId
                    ..lenderName = result.lenderName
                    ..capital = result.capital;

                  return ResultadosPage(user: user, solicitud: solicitud);
                },
                closedElevation: 0,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                closedColor: buttonColor,
                closedBuilder:
                    (context, openContainer) => ElevatedButton(
                      onPressed: excedeDescuento ? null : openContainer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        excedeDescuento ? 'Límite excedido' : 'Solicitar',
                        style: AppTextStyles.buttonText(context).copyWith(
                          fontSize: 12.sp,
                          color: excedeDescuento ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 15.w,
            runSpacing: 12.h,
            children: [
              _buildDato(
                context,
                label: capitalLabel,
                value: '${formatCurrency.format(result.capital)} MXN',
                labelFontSize: labelFontSize,
                valueFontSize: valueFontSize,
              ),
              _buildDato(
                context,
                label: 'Tasa Anual',
                value: '${result.effectiveAnnualRate.toStringAsFixed(2)}%',
                labelFontSize: labelFontSize,
                valueFontSize: valueFontSize,
              ),
              _buildDato(
                context,
                label: 'Tasa x Periodo',
                value: '${result.effectivePeriodRate.toStringAsFixed(2)}%',
                labelFontSize: labelFontSize,
                valueFontSize: valueFontSize,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDato(
    BuildContext context, {
    required String label,
    required String value,
    required double labelFontSize,
    required double valueFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall(context).copyWith(
            fontSize: labelFontSize,
            color: AppColors.textPrimary(context),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.promoBold(
            context,
          ).copyWith(fontSize: valueFontSize),
        ),
      ],
    );
  }
}
