import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/widget/formulario_simulacion.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';

class SimulacionPage extends StatelessWidget {
  final User user;
  const SimulacionPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            //  Icono de regreso y título
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
                        const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
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
            const SizedBox(height: 40),

            // 🔻 Formulario
            FormularioSimulacion(user: user),
            const SizedBox(height: 40),

            // 🔻 Texto informativo CAT
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      style: AppTextStyles.bodySmall(
                        context,
                      ).copyWith(height:1.1),
                      children: [
                        TextSpan(
                          text: 'Costo Anual Total ',
                          style: TextStyle(color: Colors.teal[800]),
                        ),
                        TextSpan(
                          text: '(CAT)',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' promedio vigente '),
                        TextSpan(
                          text: 'SIN IVA',
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ', presentado únicamente con fines informativos y comparativos, para que el usuario pueda tomar una decisión financiera más adecuada al contratar un crédito.\n\n'
                              'Se recomienda elegir el crédito con el ',
                        ),
                        TextSpan(
                          text: 'CAT',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' más bajo, siempre considerando sus necesidades y capacidad de pago.\nPara más información o aclaraciones, puede consultar la página de la Comisión Nacional para la Protección y Defensa de los Usuarios de Servicios Financieros ',
                        ),
                        TextSpan(
                          text: '(CONDUSEF)',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ':\n'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // 🔗 Enlaces centrados
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildLink(context, 'www.buro.gob.mx'),
                        const SizedBox(height: 6),
                        _buildLink(context, 'www.condusef.gob.mx'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(BuildContext context, String url) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.link, size: 16, color: Colors.orange),
        const SizedBox(width: 6),
        Text(
          url,
          style: AppTextStyles.linkMuted(context).copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
