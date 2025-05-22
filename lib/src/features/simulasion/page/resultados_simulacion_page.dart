import 'package:app_creditos/src/features/simulasion/page/resultados_simulacion_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/widget/resultado_simulacion_card.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadosSimulacionPage extends StatelessWidget {
  final List<SimulacionResult> resultados;
  final User user;
  final SolicitudCreditoData solicitud;

  const ResultadosSimulacionPage({
    super.key,
    required this.resultados,
    required this.user,
    required this.solicitud,
  });

  bool get isLoading => resultados.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: user),
      body: isLoading
          ? const ResultadosSimulacionSkeleton()
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              physics: const ClampingScrollPhysics(),
              children: [
                /// 🔙 Encabezado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Simulación',
                            style: AppTextStyles.titleheader(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Gestiona tu cuenta de manera rápida y sencilla.',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.text(context),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                /// 🥇 Mejor opción
                Container(
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(bottom: 24.h),
                  decoration: BoxDecoration(
                    color: AppColors.promoCardBackground(context),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: ResultadoSimulacionCard(
                    result: resultados.first,
                    isTopOption: true,
                    ranking: 1,
                    user: user,
                    solicitud: solicitud,
                  ),
                ),

                /// 🔽 Lista del resto
                ...List.generate(
                  resultados.length - 1,
                  (i) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ResultadoSimulacionCard(
                      result: resultados[i + 1],
                      ranking: i + 2,
                      user: user,
                      solicitud: solicitud,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
