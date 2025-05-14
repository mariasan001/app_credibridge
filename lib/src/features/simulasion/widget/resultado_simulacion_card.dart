import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadoSimulacionCard extends StatelessWidget {
  final SimulacionResult result;
  final bool isTopOption;
  final int? ranking;

  const ResultadoSimulacionCard({
    super.key,
    required this.result,
    this.isTopOption = false,
    this.ranking,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isTopOption ? const Color(0xFFE6F4EA) : Colors.white;
    final borderColor = isTopOption ? const Color(0xFF22C55E) : const Color(0xFFE5E5E5);
    final buttonColor = isTopOption ? const Color(0xFF22C55E) : Colors.grey.shade400;
    final icon = isTopOption ? Icons.emoji_events_outlined : Icons.account_balance;
    final iconColor = isTopOption ? const Color(0xFF22C55E) : AppColors.primary;
    final formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$', decimalDigits: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTopOption) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '🥇 La mejor opción para ti',
              style: AppTextStyles.titleheader(context).copyWith(fontSize: 20),
            ),
          ),
        ] else if (ranking == 2) ...[
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 12),
            child: Text(
              'Otras opciones',
              style: AppTextStyles.titleheader(context).copyWith(fontSize: 20),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                result.lenderName,
                                style: AppTextStyles.promoBold(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: isTopOption ? 2 : 0,
                              ),
                              child: Text(
                                'Solicitar Crédito',
                                style: AppTextStyles.buttonText(context).copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          result.serviceTypeDesc.toUpperCase(),
                          style: AppTextStyles.bodySmall(context).copyWith(letterSpacing: 0.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Capital', style: AppTextStyles.bodySmall(context)),
                      const SizedBox(height: 2),
                      Text(
                        '${formatCurrency.format(result.capital)} MXN',
                        style: AppTextStyles.promoBold(context).copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tasa Anual', style: AppTextStyles.bodySmall(context)),
                      const SizedBox(height: 2),
                      Text(
                        '${result.effectiveAnnualRate.toStringAsFixed(2)}%',
                        style: AppTextStyles.promoBold(context).copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tasa x Periodo', style: AppTextStyles.bodySmall(context)),
                      const SizedBox(height: 2),
                      Text(
                        '${result.effectivePeriodRate.toStringAsFixed(2)}%',
                        style: AppTextStyles.promoBold(context).copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
