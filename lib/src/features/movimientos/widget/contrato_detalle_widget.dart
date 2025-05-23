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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
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
            // Título
            Text(
              "Tu saldo pendiente",
              style: AppTextStyles.promoTitle(
                context,
              ).copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontSize: 12.sp, 
                  color: const Color(0xFF746343),
                ),
                children: [
                  const TextSpan(text: "Otorgado por: "),
                  TextSpan(
                    text:
                        (contrato.lenderName.isNotEmpty)
                            ? contrato.lenderName
                            : "Institución no disponible",
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontSize: 12.sp, 
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF746343),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // los widgets separados aquí:
            MontoDestacado(monto: contrato.newBalance),
            SizedBox(height: 8.h),
            TextoPrestamoSolicitado(monto: contrato.amount),
            SizedBox(height: 20.h),
            ResumenCuotas(
              total: contrato.installments,
              actual: contrato.discountsAplied,
              restantes: cuotasRestantes,
            ),
          ],
        ),
      ),
    );
  }
}
