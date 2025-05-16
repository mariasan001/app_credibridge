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
    final paddingValue = isTablet ? 24.0 : 14.0;
    final labelFontSize = isTablet ? 14.0 : 10.0;
    final valueFontSize = isTablet ? 16.0 : 14.0;

    final backgroundColor =
        isTopOption
            ? const Color(0xFFE6F4EA)
            : Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2A2A2A)
            : Colors.white;

    final borderColor =
        isTopOption
            ? const Color(0xFF22C55E)
            : Theme.of(context).brightness == Brightness.dark
            ? Colors.white12
            : const Color(0xFFE5E5E5);

    final buttonColor =
        isTopOption ? const Color(0xFF22C55E) : Colors.grey.shade400;
    final icon =
        isTopOption ? Icons.emoji_events_outlined : Icons.account_balance;
    final iconColor = isTopOption ? const Color(0xFF22C55E) : AppColors.primary;

    final formatCurrency = NumberFormat.currency(
      locale: 'es_MX',
      symbol: '\$',
      decimalDigits: 2,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTopOption)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '🥇 La mejor opción para ti',
              style: AppTextStyles.titleheader(
                context,
              ).copyWith(fontSize: isTablet ? 22 : 16),
            ),
          )
        else if (ranking == 2)
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              'Otras opciones',
              style: AppTextStyles.titleheader(
                context,
              ).copyWith(fontSize: isTablet ? 22 : 16),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(paddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: iconColor.withOpacity(0.15),
                    child: Icon(icon, color: iconColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                result.lenderName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.promoBold(
                                  context,
                                ).copyWith(fontSize: isTablet ? 16 : 12),
                              ),
                            ),
                            const SizedBox(width: 150),
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  // 🟢 Guardamos todos los datos importantes
                                  solicitud
             
                                    ..tipoSimulacion = solicitud.tipoSimulacion
                                    ..monto = solicitud.monto
                                    ..plazo = solicitud.plazo
                                    ..tasaAnual = result.effectiveAnnualRate
                                    ..tasaPorPeriodo =
                                        result.effectivePeriodRate
                                    ..lenderId = result.lenderId
                                    ..lenderName = result.lenderName
                                    ..capital = result.capital;

                                  // 🚀 Navegamos a ResultadosPage
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isTablet ? 14 : 4,
                                    vertical: isTablet ? 12 : 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    'Solicitar',
                                    style: AppTextStyles.buttonText(
                                      context,
                                    ).copyWith(fontSize: isTablet ? 14 : 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 0),
                        Text(
                          result.serviceTypeDesc.toUpperCase(),
                          style: AppTextStyles.bodySmall(
                            context,
                          ).copyWith(fontSize: labelFontSize, letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 25,
                runSpacing: 1,
                children: [
                  _buildDato(
                    context,
                    label: 'Capital',
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
        ),
      ],
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
