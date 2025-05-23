import 'package:app_creditos/src/features/simulasion/page/simulacion_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/widget/formulario_simulacion.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';

class SimulacionPage extends StatefulWidget {
  final User user;
  final double? descuento;

  const SimulacionPage({
    super.key,
    required this.user,
    required this.descuento,
  });

  @override
  State<SimulacionPage> createState() => _SimulacionPageState();
}

class _SimulacionPageState extends State<SimulacionPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Simula carga de datos por UX, o reemplaza con lógica real
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: isLoading || widget.descuento == null
          ? const SimulacionSkeleton()
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              physics: const ClampingScrollPhysics(),
              children: [
                /// Encabezado
                Column(
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
                    SizedBox(height: 1.h),
                    Text(
                      'Gestiona tu cuenta de manera rápida y sencilla.',
                      style: AppTextStyles.bodySmall(context),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                ///Formulario
                FormularioSimulacion(
                  user: widget.user,
                  descuento: widget.descuento!,
                ),

                SizedBox(height: 40.h),

                ///Información CAT
                _buildCatInfo(context),

                SizedBox(height: 24.h),
              ],
            ),
    );
  }

  Widget _buildCatInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              style: AppTextStyles.bodySmall(context).copyWith(
                height: 1.3,
                color: AppColors.textPrimary(context),
              ),
              children: [
                TextSpan(
                  text: 'Costo Anual Total ',
                  style: TextStyle(color: AppColors.primary),
                ),
                TextSpan(
                  text: '(CAT)',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' promedio vigente '),
                TextSpan(
                  text: 'SIN IVA',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      ', presentado únicamente con fines informativos y comparativos.\n\nRecomendamos elegir el crédito con el ',
                ),
                TextSpan(
                  text: 'CAT',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      ' más bajo, siempre considerando tus necesidades y capacidad de pago.\n\nPara más info, visita la página de ',
                ),
                TextSpan(
                  text: 'CONDUSEF',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ':\n'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Column(
            children: [
              _buildLink(context, 'www.buro.gob.mx'),
              SizedBox(height: 6.h),
              _buildLink(context, 'www.condusef.gob.mx'),
            ],
          ),
        ],
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
