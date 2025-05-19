import 'package:app_creditos/src/features/simulasion/page/solicitar_credito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$', decimalDigits: 2);

    final bool excedeDescuento = solicitud.tipoSimulacion?.id == 1 &&
        solicitud.descuento != null &&
        result.capital > solicitud.descuento!;

    final String capitalLabel = solicitud.tipoSimulacion?.id == 1 ? 'Descuento' : 'Crédito';

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isTopOption
              ? AppColors.primary
              : Theme.of(context).brightness == Brightness.dark
                  ? Colors.white12
                  : const Color(0xFFE5E5E5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTopOption)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Icon(Icons.star_rounded, color: AppColors.iconColorStrong, size: 22.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Mejor opción para ti',
                    style: AppTextStyles.titleheader(context).copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  isTopOption ? Icons.emoji_events_outlined : Icons.account_balance,
                  color: isTopOption ? AppColors.iconColorStrong : AppColors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.lenderName,
                      style: AppTextStyles.promoBold(context).copyWith(fontSize: 15.sp),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      result.serviceTypeDesc.toUpperCase(),
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: excedeDescuento
                    ? null
                    : () {
                        solicitud
                          ..tasaAnual = result.effectiveAnnualRate
                          ..tasaPorPeriodo = result.effectivePeriodRate
                          ..lenderId = result.lenderId
                          ..lenderName = result.lenderName
                          ..capital = result.capital;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultadosPage(user: user, solicitud: solicitud),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: excedeDescuento
                      ? Colors.red
                      : isTopOption
                          ? AppColors.iconColorStrong
                          : AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 25.w,
            runSpacing: 12.h,
            children: [
              _buildDato(context, label: capitalLabel, value: '${formatCurrency.format(result.capital)} MXN'),
              _buildDato(context, label: 'Tasa Anual', value: '${result.effectiveAnnualRate.toStringAsFixed(2)}%'),
              _buildDato(context, label: 'Tasa x Periodo', value: '${result.effectivePeriodRate.toStringAsFixed(2)}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDato(BuildContext context, {required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall(context).copyWith(fontSize: 12.sp)),
        SizedBox(height: 2.h),
        Text(value, style: AppTextStyles.promoBold(context).copyWith(fontSize: 14.sp)),
      ],
    );
  }
}
