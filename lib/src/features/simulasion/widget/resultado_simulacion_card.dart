import 'package:app_creditos/src/features/simulasion/page/solicitar_credito.dart';
import 'package:flutter/material.dart';
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
    final isTablet = MediaQuery.of(context).size.width > 600;
    final paddingValue = isTablet ? 24.0 : 16.0;
    final labelFontSize = isTablet ? 14.0 : 11.0;
    final valueFontSize = isTablet ? 18.0 : 15.0;

    final backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : Colors.white;

    final borderColor =
        isTopOption
            ? AppColors.primary
            : Theme.of(context).brightness == Brightness.dark
            ? Colors.white12
            : const Color(0xFFE5E5E5);

    final icon =
        isTopOption ? Icons.emoji_events_outlined : Icons.account_balance;
    final iconColor =
        isTopOption ? AppColors.iconColorStrong : AppColors.primary;

    final formatCurrency = NumberFormat.currency(
      locale: 'es_MX',
      symbol: '\$',
      decimalDigits: 2,
    );

    final bool excedeDescuento =
        solicitud.tipoSimulacion?.id == 1 &&
        solicitud.descuento != null &&
        result.capital > solicitud.descuento!;

    final buttonColor =
        excedeDescuento
            ? Colors.red
            : (isTopOption ? AppColors.iconColorStrong : AppColors.primary);
    final String capitalLabel =
        solicitud.tipoSimulacion?.id == 1
            ? 'Descuento'
            : 'Credito';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTopOption)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.iconColorStrong,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Mejor opción para ti',
                    style: AppTextStyles.titleheader(
                      context,
                    ).copyWith(fontSize: isTablet ? 18 : 14),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.lenderName,
                      style: AppTextStyles.promoBold(
                        context,
                      ).copyWith(fontSize: valueFontSize),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      result.serviceTypeDesc.toUpperCase(),
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontSize: labelFontSize,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed:
                    excedeDescuento
                        ? null
                        : () {
                          solicitud
                            ..tipoSimulacion = solicitud.tipoSimulacion
                            ..monto = solicitud.monto
                            ..plazo = solicitud.plazo
                            ..tasaAnual = result.effectiveAnnualRate
                            ..tasaPorPeriodo = result.effectivePeriodRate
                            ..lenderId = result.lenderId
                            ..lenderName = result.lenderName
                            ..capital = result.capital;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ResultadosPage(
                                    user: user,
                                    solicitud: solicitud,
                                  ),
                            ),
                          );
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  excedeDescuento ? 'Límite excedido' : 'Solicitar',
                  style: AppTextStyles.buttonText(context).copyWith(
                    fontSize: isTablet ? 14 : 12,
                    color: excedeDescuento ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Wrap(
            spacing: 25,
            runSpacing: 12,
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
          style: AppTextStyles.bodySmall(
            context,
          ).copyWith(fontSize: labelFontSize),
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
