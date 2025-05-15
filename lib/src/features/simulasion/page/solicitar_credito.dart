import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class SolicitudCreditoPage extends StatelessWidget {
  const SolicitudCreditoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de Crédito'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Completa tu solicitud',
              style: AppTextStyles.titleheader(context),
            ),
            const SizedBox(height: 12),
            Text(
              'Para continuar con tu crédito, por favor completa los siguientes datos.',
              style: AppTextStyles.bodySmall(context),
            ),
            const SizedBox(height: 24),

            // Aquí irán los campos del formulario

            const TextField(
              decoration: InputDecoration(labelText: 'Monto solicitado'),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(labelText: 'Plazo en meses'),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // lógica para enviar solicitud
                },
                child: Text('Enviar Solicitud'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
