import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadosPage extends StatelessWidget {
  final User user;
  final SolicitudCreditoData solicitud;

  const ResultadosPage({
    super.key,
    required this.user,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: user),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    'Simulación',
                    style: AppTextStyles.titleheader(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Estos son los datos que seleccionaste:',
              style: AppTextStyles.bodySmall(context),
            ),
            const SizedBox(height: 24),

            _buildDato(context, 'ID Usuario', '${user.userId}'),
            _buildDato(context, 'Tipo de simulación', solicitud.tipoSimulacion?.name ?? '-'),
            _buildDato(context, 'ID Tipo simulación', '${solicitud.tipoSimulacion?.id ?? '-'}'),
            _buildDato(context, 'Monto solicitado', '\$${solicitud.monto?.toStringAsFixed(2) ?? '-'}'),
            _buildDato(context, 'Plazo', '${solicitud.plazo ?? '-'} meses'),
            _buildDato(context, 'Tasa anual', '${solicitud.tasaAnual?.toStringAsFixed(2) ?? '-'}%'),
            _buildDato(context, 'Tasa x periodo', '${solicitud.tasaPorPeriodo?.toStringAsFixed(2) ?? '-'}%'),
            _buildDato(context, 'ID Financiera', '${solicitud.lenderId ?? '-'}'),
            _buildDato(context, 'Nombre Financiera', solicitud.lenderName ?? '-'),
            _buildDato(context, 'Capital', '${solicitud.capital ?? '-'}'),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí va el POST final
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Solicitar crédito',
                  style: AppTextStyles.buttonText(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDato(BuildContext context, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: AppTextStyles.bodySmall(context)),
          Text(valor, style: AppTextStyles.bodySmall(context)),
        ],
      ),
    );
  }
}
