import 'package:flutter/material.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/widget/resultado_simulacion_card.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadosSimulacionPage extends StatelessWidget {
  final List<SimulacionResult> resultados;
  final User user;
  final SolicitudCreditoData solicitud;

  const ResultadosSimulacionPage({
    super.key,
    required this.resultados,
    required this.user,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: user),
      body: resultados.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No se encontraron resultados disponibles para tu simulación.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall(context),
                ),
              ),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título, subtítulo y botón regresar
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.arrow_back_ios_new_rounded,
                                  size: 18),
                              const SizedBox(width: 4),
                              Text(
                                'Simulación',
                                style: AppTextStyles.titleheader(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Gestiona tu cuenta de manera rápida y sencilla.',
                          style: AppTextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🥇 Tarjeta mejor opción
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ResultadoSimulacionCard(
                      result: resultados.first,
                      isTopOption: true,
                      ranking: 1,
                      user: user,
                      solicitud: solicitud,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🔽 Lista del resto
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(
                        resultados.length - 1,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ResultadoSimulacionCard(
                            result: resultados[i + 1],
                            ranking: i + 2,
                            user: user,
                            solicitud: solicitud,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
