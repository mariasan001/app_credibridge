import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ContratoDetalleWidget extends StatelessWidget {
  final ContractModel contrato;

  const ContratoDetalleWidget({super.key, required this.contrato, required bool isActive});

  bool esPrestamoReal(ContractModel contrato) {
    final tipo = contrato.serviceTypeDesc.toLowerCase();
    final esSeguro = tipo.contains('seguro');
    final esPrestamoTexto =
        tipo.contains('préstamo') || tipo.contains('prestamo');
    final montoValido = contrato.amount > 1000;
    final tienePagos = contrato.installments > 1;
    final tieneDescuento =
        contrato.biweeklyDiscount > 0 && contrato.biweeklyDiscount < 5000;
    final tieneSaldos = contrato.lastBalance > 0 || contrato.newBalance > 0;
    return !esSeguro &&
        (esPrestamoTexto ||
            (montoValido && tienePagos && tieneDescuento && tieneSaldos));
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
    final cuotasRestantes = contrato.installments - contrato.discountsAplied;

    final Color iconColor =
        esSeguro
            ? const Color.fromARGB(255, 11, 116, 202)
            : esPrestamo
            ? const Color.fromARGB(255, 223, 109, 2)
            : Colors.grey;
    final Color bgColor = iconColor.withOpacity(0.15);

    final String tipoServicio =
        contrato.serviceTypeDesc.trim().isEmpty
            ? "No disponible "
            : contrato.serviceTypeDesc;

    final String otorgadoPor =
        contrato.lenderName.isNotEmpty
            ? contrato.lenderName
            : "Institución no disponible";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 4.h),
      child: Container(
        padding: EdgeInsets.all(20.r),
   
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Encabezado
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: iconColor,
                      size: 20.r,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tipoServicio,
                        style: AppTextStyles.heading(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Otorgado por: $otorgadoPor',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            /// Monto actual
            Text(
              '\$${formatter.format(contrato.newBalance)}',
              style: TextStyle(
                fontSize: 42.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),

            /// Monto original
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                ' \$${formatter.format(contrato.amount)}',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: const Color.fromARGB(255, 204, 204, 204),
                ),
              ),
            ),

            /// Cuotas restantes (solo para préstamos)
            if (esPrestamo)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '$cuotasRestantes cuotas restantes',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 3, 94, 8),
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
