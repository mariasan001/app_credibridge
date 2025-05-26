import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';

class TextoPrestamoSolicitado extends StatelessWidget {
  final ContractModel contrato;

  const TextoPrestamoSolicitado({
    super.key,
    required this.contrato,
  });

  bool esPrestamoReal(ContractModel contrato) {
    final tipo = contrato.serviceTypeDesc.toLowerCase();

    final esSeguro = tipo.contains('seguro');
    final esPrestamoTexto = tipo.contains('préstamo') || tipo.contains('prestamo');

    final montoValido = contrato.amount > 1000;
    final tienePagos = contrato.installments > 1;
    final tieneDescuento = contrato.biweeklyDiscount > 0 && contrato.biweeklyDiscount < 5000;
    final tieneSaldos = contrato.lastBalance > 0 || contrato.newBalance > 0;

    return !esSeguro && (esPrestamoTexto || (montoValido && tienePagos && tieneDescuento && tieneSaldos));
  }

  @override
  Widget build(BuildContext context) {
    final montoFormateado = NumberFormat.currency(
      locale: 'es_MX',
      symbol: '\$',
    ).format(contrato.amount);

    final tipo = contrato.serviceTypeDesc.toLowerCase();
    final esSeguro = tipo.contains('seguro');
    final esPrestamo = esPrestamoReal(contrato);

    if (esPrestamo) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.bodySmall(context).copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted(context),
          ),
          children: [
            const TextSpan(text: 'De un préstamo solicitado de '),
            TextSpan(
              text: '$montoFormateado MX',
              style: AppTextStyles.bodySmall(context).copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted(context),
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        esSeguro
            ? "Tu seguro está vigente desde el 1 Ene 2024"
            : "Servicio activo desde el 1 Ene 2024",
        style: AppTextStyles.bodySmall(context).copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}
