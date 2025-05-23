import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResumenPagoCard extends StatelessWidget {
  final ContractModel contrato;

  const ResumenPagoCard({super.key, required this.contrato});

  @override
  Widget build(BuildContext context) {
    final ahora = DateTime.now();
    final dia = ahora.day;

    // Próximo descuento
    DateTime proximo;
    if (dia < 15) {
      proximo = DateTime(ahora.year, ahora.month, 15);
    } else {
      final nextMonth = DateTime(ahora.year, ahora.month + 1, 1);
      proximo = DateTime(nextMonth.year, nextMonth.month, 0); // último día
    }

    // Último descuento
    DateTime ultimo;
    if (dia >= 15) {
      ultimo = DateTime(ahora.year, ahora.month, 15);
    } else {
      final prevMonth = DateTime(ahora.year, ahora.month, 1).subtract(const Duration(days: 1));
      ultimo = DateTime(prevMonth.year, prevMonth.month, 15);
    }

    final monto = contrato.biweeklyDiscount;
    final tienePagos = contrato.discountsAplied > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBloquePago(
          context,
          isProximo: true,
          fecha: proximo,
          monto: monto,
          color: const Color(0xFFF5D875),
          icon: Icons.payments_outlined,
          titulo: "Próximo descuento",
          textoMonto: "El retiro de su nómina será de",
        ),
        SizedBox(height: 20.h),
        tienePagos
            ? _buildBloquePago(
                context,
                isProximo: false,
                fecha: ultimo,
                monto: monto,
                color: Colors.grey.shade400,
                icon: Icons.history,
                titulo: "Último descuento",
                textoMonto: "El retiro de su nómina fue de",
                esGris: true,
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    "No hay descuentos anteriores registrados",
                    style: AppTextStyles.bodySmall(context),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildBloquePago(
    BuildContext context, {
    required bool isProximo,
    required DateTime fecha,
    required double monto,
    required Color color,
    required IconData icon,
    required String titulo,
    required String textoMonto,
    bool esGris = false,
  }) {
    final formatter = DateFormat("d 'de' MMMM 'del' y", 'es_MX');
    final montoFormateado =
        NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(monto);

    final textoColor = esGris ? Colors.grey : AppColors.text(context);
    final negritaColor = esGris ? Colors.grey.shade600 : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 28.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$titulo ${isProximo ? 'es el' : 'fue el'} ${formatter.format(fecha)}",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: textoColor,
                  ),
                ),
                SizedBox(height: 4.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: textoColor,
                    ),
                    children: [
                      TextSpan(text: "$textoMonto "),
                      TextSpan(
                        text: montoFormateado,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: negritaColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                GestureDetector(
                  onTap: () {
                    // 👉 Aquí navegas a la pantalla de aclaración
                    Navigator.pushNamed(context, '/aclaracion', arguments: contrato);
                  },
                  child: Text(
                    "Solicitar Aclaración",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.teal[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
