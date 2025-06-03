import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/movimientos/page/historial_page.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/seleccionar_financiera_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResumenPagoCard extends StatelessWidget {
  final ContractModel contrato;
  final User user;

  const ResumenPagoCard({
    super.key,
    required this.contrato,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final ahora = DateTime.now();
    final dia = ahora.day;

    DateTime proximo = dia < 15
        ? DateTime(ahora.year, ahora.month, 15)
        : DateTime(ahora.year, ahora.month + 1, 0);

    final formatterFecha = DateFormat("d MMM y", 'es_MX');
    final formatterMonto = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

    final montoFormateado = formatterMonto.format(contrato.biweeklyDiscount);
    final partes = montoFormateado.split('.');

    final lastPayment = contrato.lastPayment;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9.w, vertical: 12.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.promoCardBackground(context),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.promoShadow(context),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Encabezado
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Historial",
                  style: AppTextStyles.promoButtonText2(context),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 20.sp,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HistorialPage(
                            contrato: contrato,
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 3.w),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.help_outline,
                      size: 20.sp,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ReportePaso1FinancieraPage(user: user),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 14.h),

          /// Próximo descuento
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: const Color.fromARGB(255, 8, 119, 81),
                child: Icon(
                  Icons.payments_outlined,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Próximo descuento",
                      style: AppTextStyles.promoBold(context),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      formatterFecha.format(proximo),
                      style: AppTextStyles.promoFooterDate(context),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.promoTitle(context),
                  children: [
                    TextSpan(text: '${partes[0]}.'),
                    TextSpan(
                      text: partes.length > 1 ? partes[1] : '00',
                      style: AppTextStyles.promoTitle(context).copyWith(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// Separador
          Container(
            margin: EdgeInsets.symmetric(vertical: 14.h),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: List.generate(
                    (constraints.maxWidth / 10).floor(),
                    (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Último descuento
          contrato.discountsAplied > 0 && lastPayment != null
              ? Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Último descuento",
                            style: AppTextStyles.promoListText(context).copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            formatterFecha.format(lastPayment.date),
                            style: AppTextStyles.promoFooterDate(context).copyWith(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.promoBold(context),
                        children: [
                          TextSpan(
                            text: '${partes[0]}.',
                            style: AppTextStyles.promoBold(context).copyWith(
                              fontSize: 16.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          TextSpan(
                            text: partes.length > 1 ? partes[1] : '00',
                            style: AppTextStyles.promoBold(context).copyWith(
                              fontSize: 10.sp,
                              color: const Color.fromARGB(255, 170, 170, 170),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20.sp,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "No se ha registrado ningún descuento aún",
                          style: AppTextStyles.bodySmall(context).copyWith(
                            fontSize: 12.sp,
                            color: Colors.grey.shade500,
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
