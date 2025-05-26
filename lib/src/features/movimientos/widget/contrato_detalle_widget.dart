import 'package:app_creditos/src/features/movimientos/widget/monto_destacado.dart';
import 'package:app_creditos/src/features/movimientos/widget/resumen_cuotas.dart';
import 'package:app_creditos/src/features/movimientos/widget/texto-prestamo_solicitado.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContratoDetalleWidget extends StatelessWidget {
  final ContractModel contrato;

  const ContratoDetalleWidget({super.key, required this.contrato});

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
    final cuotasRestantes = contrato.installments - contrato.discountsAplied;
    final tipo = contrato.serviceTypeDesc.toLowerCase();
    final esSeguro = tipo.contains('seguro');
    final esPrestamo = esPrestamoReal(
      contrato,
    ); // ⬅️ Aquí aplicamos la detección refinada

    String obtenerTitulo() {
      if (esSeguro) return "Pago de seguro";
      if (esPrestamo) return "Tu saldo pendiente";
      return "Servicio activo";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AppColors.promoCardBackground(context),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.promoShadow(context),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              obtenerTitulo(),
              style: AppTextStyles.promoTitle(
                context,
              ).copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),

            // Otorgado por
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.bodySmall(
                  context,
                ).copyWith(fontSize: 13.sp, color: const Color(0xFF746343)),
                children: [
                  TextSpan(
                    text: "Otorgado por: ",
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text(context),
                    ),
                  ),
                  TextSpan(
                    text:
                        contrato.lenderName.isNotEmpty
                            ? contrato.lenderName
                            : "Institución no disponible",
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textCar(context),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 18.h),
            MontoDestacado(contrato: contrato),
            SizedBox(height: 12.h),
            TextoPrestamoSolicitado(contrato: contrato),

            // Mostrar cuotas también si es préstamo oculto
            if (esPrestamo) ...[
              SizedBox(height: 25.h),
              ResumenCuotas(
                total: contrato.installments,
                actual: contrato.discountsAplied,
                restantes: cuotasRestantes,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
