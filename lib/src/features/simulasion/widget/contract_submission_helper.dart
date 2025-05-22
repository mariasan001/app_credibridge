import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/contract_model.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/services/contact_service.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';

Future<void> enviarContrato({
  required BuildContext context,
  required User user,
  required SolicitudCreditoData solicitud,
  required String telefono,
}) async {
  if (telefono.isEmpty || telefono.length < 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor ingresa un número válido.')),
    );
    return;
  }

  if (solicitud.lenderId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('❌ No se encontró la financiera seleccionada.')),
    );
    return;
  }

  final contrato = ContratoModel(
    lenderId: solicitud.lenderId!,
    userId: user.userId.toString(),
    contractType: solicitud.tipoSimulacion?.id ?? 0,
    installments: solicitud.plazo ?? 0,
    amount: solicitud.capital ?? 0,
    monthlyDeductionAmount: solicitud.monto?.round() ?? 0,
    effectiveRate: solicitud.tasaPorPeriodo ?? 0,
    effectiveAnnualRate: solicitud.tasaAnual ?? 0,
    phone: telefono,
  );

  try {
    await ContractService.crearContrato(contrato);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Contrato enviado correctamente')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage(user: user)),
        (route) => false,
      );
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Error al enviar el contrato')),
      );
    }
  }
}
