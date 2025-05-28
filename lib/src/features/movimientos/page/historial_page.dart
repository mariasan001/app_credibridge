import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/seleccionar_financiera_page.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class HistorialPage extends StatelessWidget {
  final ContractModel contrato;
  final User user;

  const HistorialPage({super.key, required this.contrato, required this.user});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("d MMM y", 'es_MX');
    final formatterMonto = NumberFormat.currency(locale: 'es_MX', symbol: '');

    final lastPayment = contrato.lastPayment;
    final nextPayment = contrato.nextPayment;

    return Scaffold(
      appBar: CustomAppBar(user: user),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Historial",
                  style: AppTextStyles.promoTitle(
                    context,
                  ).copyWith(fontSize: 18.sp),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                ReportePaso1FinancieraPage(user: user),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: Text(
                    "Crear reporte",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            /// Próximo pago
            if (nextPayment != null)
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.promoCardBackground(context),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: const Color(0xFF0C9B6E),
                      child: Icon(
                        Icons.payments_outlined,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Próximo descuento",
                            style: AppTextStyles.promoBold(
                              context,
                            ).copyWith(fontSize: 13.sp),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            formatter.format(nextPayment.date),
                            style: AppTextStyles.promoFooterDate(context),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text:
                            '\$${formatterMonto.format(nextPayment.amount).split('.')[0]}.',
                        style: AppTextStyles.promoTitle(context),
                        children: [
                          TextSpan(
                            text:
                                formatterMonto
                                    .format(nextPayment.amount)
                                    .split('.')[1],
                            style: AppTextStyles.promoTitle(context).copyWith(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          TextSpan(
                            text: ' mx',
                            style: AppTextStyles.promoFooterDate(
                              context,
                            ).copyWith(
                              fontSize: 11.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (nextPayment != null) ...[
              SizedBox(height: 16.h),
              Row(
                children: List.generate(
                  100 ~/ 2,
                  (index) => Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],

            /// Último pago
            lastPayment != null
                ? Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.promoCardBackground(context),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey.shade400,
                        child: Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Último descuento",
                              style: AppTextStyles.promoBold(
                                context,
                              ).copyWith(fontSize: 13.sp),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              formatter.format(lastPayment.date),
                              style: AppTextStyles.promoFooterDate(context),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                              '\$${formatterMonto.format(lastPayment.amount).split('.')[0]}.',
                          style: AppTextStyles.promoBold(context).copyWith(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  formatterMonto
                                      .format(lastPayment.amount)
                                      .split('.')[1],
                              style: AppTextStyles.promoBold(context).copyWith(
                                fontSize: 11.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            TextSpan(
                              text: ' mx',
                              style: AppTextStyles.bodySmall(context).copyWith(
                                fontSize: 10.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                : Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
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
      ),
    );
  }
}
