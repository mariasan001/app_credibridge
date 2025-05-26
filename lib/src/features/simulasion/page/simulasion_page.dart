import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/page/simulacion_skeleton.dart';
import 'package:app_creditos/src/features/simulasion/widget/formulario_simulacion.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
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
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body:
          isLoading || widget.descuento == null
              ? const SimulacionSkeleton()
              : ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                physics: const ClampingScrollPhysics(),
                children: [
                  _buildHeader(context),
                  SizedBox(height: 24.h),
                  _buildSimulacionCard(context),
                  SizedBox(height: 32.h),
                  _buildCatInfo(context),
                  SizedBox(height: 32.h),
                ],
              ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Botón de retroceso
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                child: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: AppColors.cuotasColor,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            // Título principal
            Text(
              'Simula tu préstamo',
              style: AppTextStyles.heading(context).copyWith(fontSize: 18.sp),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Elige cuánto necesitas y en cuántos pagos lo devolverás.',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textMuted(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSimulacionCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (Theme.of(context).brightness == Brightness.light)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4.h),
            ),
        ],
      ),
      child: FormularioSimulacion(
        user: widget.user,
        descuento: widget.descuento!,
      ),
    );
  }

  Widget _buildCatInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (Theme.of(context).brightness == Brightness.light)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: Offset(0, 3.h),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.orange),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '¿Qué es el CAT?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.help_outline,
                        size: 20.sp,
                        color: AppColors.primary,
                      ),
                      onPressed: () => _showCatDialog(context),
                      tooltip: 'Más información',
                    ),
                  ],
                ),
                Text(
                  'Haz clic en el ícono para conocer más sobre el CAT y cómo afecta tu préstamo.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textMuted(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.orange),
              SizedBox(width: 8.w),
              Text(
                'Información sobre el CAT',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                children: [
                  const TextSpan(text: 'El '),
                  TextSpan(
                    text: 'Costo Anual Total (CAT)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ' promedio vigente sin IVA se presenta únicamente con fines informativos y comparativos.\n\nRecomendamos elegir el crédito con el ',
                  ),
                  TextSpan(
                    text: 'CAT más bajo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ', siempre considerando tus necesidades y capacidad de pago.\n\nPara más información, visita:',
                  ),
                  TextSpan(
                    text: '\n• www.buro.gob.mx\n• www.condusef.gob.mx',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.orange),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
