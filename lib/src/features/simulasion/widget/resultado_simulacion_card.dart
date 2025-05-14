// lib/src/features/simulacion/widgets/resultado_simulacion_card.dart

import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:flutter/material.dart';

class ResultadoSimulacionCard extends StatelessWidget {
  final SimulacionResult result;

  const ResultadoSimulacionCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.lenderName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(' Tipo de servicio: ${result.serviceTypeDesc}'),
            Text(' Capital: \$${result.capital.toStringAsFixed(2)}'),
            Text(' Tasa efectiva por periodo: ${result.effectivePeriodRate.toStringAsFixed(2)}%'),
            Text(' Tasa anual efectiva: ${result.effectiveAnnualRate.toStringAsFixed(2)}%'),
            const SizedBox(height: 4),
            Text(
              ' ID Servicio Financiera: ${result.lenderServiceId}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
