// lib/src/features/simulacion/pages/resultados_simulacion_page.dart

import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/widget/resultado_simulacion_card.dart';
import 'package:flutter/material.dart';

class ResultadosSimulacionPage extends StatelessWidget {
  final List<SimulacionResult> resultados;

  const ResultadosSimulacionPage({super.key, required this.resultados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financieras disponibles')),
      body: resultados.isEmpty
          ? const Center(child: Text('No se encontraron resultados'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: resultados.length,
              itemBuilder: (context, index) {
                return ResultadoSimulacionCard(result: resultados[index]);
              },
            ),
    );
  }
}
