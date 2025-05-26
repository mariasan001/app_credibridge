import 'package:app_creditos/src/shared/theme/app_colors.dart' show AppColors;
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';

class MontoDestacado extends StatelessWidget {
  final ContractModel contrato;

  const MontoDestacado({super.key, required this.contrato});

  bool esPrestamoReal(ContractModel contrato) {
    final tipo = contrato.serviceTypeDesc.toLowerCase();

    final esSeguro = tipo.contains('seguro');
    final esPrestamoPorTexto = tipo.contains('préstamo') || tipo.contains('prestamo');

    final montoValido = contrato.amount > 1000;
    final tienePagos = contrato.installments > 1;
    final tieneDescuento = contrato.biweeklyDiscount > 0 && contrato.biweeklyDiscount < 5000;
    final tieneSaldos = contrato.lastBalance > 0 || contrato.newBalance > 0;

    // Solo si no es seguro, y se cumple la lógica o el texto dice préstamo
    return !esSeguro && (esPrestamoPorTexto || (montoValido && tienePagos && tieneDescuento && tieneSaldos));
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'es_MX',
      symbol: '',
      decimalDigits: 2,
    );
    final tipo = contrato.serviceTypeDesc.toLowerCase();
    final esSeguro = tipo.contains('seguro');
    final esPrestamo = esPrestamoReal(contrato);

    // Monto principal a mostrar
    final monto = esPrestamo ? contrato.newBalance : contrato.biweeklyDiscount;
    final partes = formatter.format(monto).split('.');

    // Color principal por tipo
    Color colorPrincipal;
    if (esPrestamo) {
      colorPrincipal = AppColors.primary;
    } else if (esSeguro) {
      colorPrincipal = AppColors.cardtextfondo(context);
    } else {
      colorPrincipal = Colors.grey.shade600;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '\$${partes[0]}.',
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w900,
                  color: colorPrincipal,
                ),
              ),
              TextSpan(
                text: partes[1],
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: colorPrincipal.withOpacity(0.7),
                ),
              ),
              TextSpan(
                text: ' mx',
                style: AppTextStyles.heading(context).copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
