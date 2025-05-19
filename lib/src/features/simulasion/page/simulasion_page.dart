import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/widget/formulario_simulacion.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';

class SimulacionPage extends StatelessWidget {
  final User user;
  final double? descuento;

  const SimulacionPage({
    super.key,
    required this.user,
    required this.descuento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: user),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),

            // 🔙 Encabezado
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(8.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
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
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // 📝 Formulario
            FormularioSimulacion(user: user, descuento: descuento!),
            SizedBox(height: 40.h),

            // ℹ️ Información CAT
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      style: AppTextStyles.bodySmall(context).copyWith(height: 1.3),
                      children: [
                        TextSpan(
                          text: 'Costo Anual Total ',
                          style: TextStyle(color: Colors.teal[800]),
                        ),
                        TextSpan(
                          text: '(CAT)',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' promedio vigente '),
                        TextSpan(
                          text: 'SIN IVA',
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ', presentado únicamente con fines informativos y comparativos, para que el usuario pueda tomar una decisión financiera más adecuada al contratar un crédito.\n\n'
                              'Se recomienda elegir el crédito con el ',
                        ),
                        TextSpan(
                          text: 'CAT',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              ' más bajo, siempre considerando sus necesidades y capacidad de pago.\nPara más información o aclaraciones, puede consultar la página de la Comisión Nacional para la Protección y Defensa de los Usuarios de Servicios Financieros ',
                        ),
                        TextSpan(
                          text: '(CONDUSEF)',
                          style: TextStyle(
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ':\n'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h),

                  // 🌐 Links
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildLink(context, 'www.buro.gob.mx'),
                        SizedBox(height: 6.h),
                        _buildLink(context, 'www.condusef.gob.mx'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(BuildContext context, String url) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.link, size: 16.sp, color: Colors.orange),
        SizedBox(width: 6.w),
        Text(
          url,
          style: AppTextStyles.linkMuted(context).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: Colors.orange,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
