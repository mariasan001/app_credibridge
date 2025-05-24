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

  @override
  Widget build(BuildContext context) {
    final cuotasRestantes = contrato.installments - contrato.discountsAplied;
    final tipo = contrato.serviceTypeDesc.toLowerCase();
    final esPrestamo = tipo.contains('préstamo') || tipo.contains('prestamo');
    final esSeguro = tipo.contains('seguro');

    String obtenerTitulo(String tipo) {
      if (esSeguro) {
        return "Estado actual de tu seguro";
      } else if (esPrestamo) {
        return "Tu saldo pendiente";
      } else {
        return "Detalle del servicio";
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h), // 🟡 Margen exterior
      child: Container(
        width: double.infinity, // 🟢 Ocupar todo el ancho
        padding: EdgeInsets.all(20.r), // 🟡 Padding interior
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
            // 🏷️ Título dinámico
            Text(
              obtenerTitulo(contrato.serviceTypeDesc),
              style: AppTextStyles.promoTitle(context).copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),

            // 🏢 Subtítulo: Otorgado por
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontSize: 12.sp,
                  color: const Color(0xFF746343),
                ),
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
                    text: contrato.lenderName.isNotEmpty
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

            // 💵 Monto principal
            MontoDestacado(
              monto: esPrestamo ? contrato.newBalance : contrato.amount,
              tipo: contrato.serviceTypeDesc,
            ),

            SizedBox(height: 12.h),

            // 📌 Texto dinámico según tipo
            TextoPrestamoSolicitado(
              monto: contrato.amount,
              tipo: contrato.serviceTypeDesc,
            ),

            // 📊 Cuotas solo si es préstamo
            if (esPrestamo) ...[
              SizedBox(height: 24.h),
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
