import 'package:app_creditos/src/features/solicitudes/page/page_solicitudes.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/contract_model.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/services/contact_service.dart';

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
      const SnackBar(
        content: Text('❌ No se encontró la financiera seleccionada.'),
      ),
    );
    return;
  }

  final int tipoSimulacion = solicitud.tipoSimulacion?.id ?? 0;

  final double amount;
  final double monthlyDeductionAmount;

  if (tipoSimulacion == 1) {
    // Por valor liberado
    amount = solicitud.monto ?? 0;
    monthlyDeductionAmount = solicitud.capital ?? 0;
  } else {
    // Por descuento quincenal
    amount = solicitud.capital ?? 0;
    monthlyDeductionAmount = solicitud.monto?.roundToDouble() ?? 0;
  }

  final contrato = ContratoModel(
    lenderId: solicitud.lenderId!,
    userId: user.userId.toString(),
    contractType: tipoSimulacion,
    installments: solicitud.plazo ?? 0,
    amount: amount,
    monthlyDeductionAmount: monthlyDeductionAmount.round(),  
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
        MaterialPageRoute(builder: (_) => PageSolicitudes(user: user)),
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
