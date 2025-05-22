import 'package:app_creditos/src/features/simulasion/page/resultados_skeleton.dart';
import 'package:app_creditos/src/features/simulasion/widget/contract_submission_helper.dart';
import 'package:app_creditos/src/features/simulasion/widget/resultados_header.dart';
import 'package:app_creditos/src/features/simulasion/widget/ticket_detalle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class ResultadosPage extends StatefulWidget {
  final User user;
  final SolicitudCreditoData solicitud;

  const ResultadosPage({
    super.key,
    required this.user,
    required this.solicitud,
  });

  @override
  State<ResultadosPage> createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  final TextEditingController _telefonoController = TextEditingController();
  bool _loading = false;
  bool _showSkeleton = true; 

  @override
  void initState() {
    super.initState();
    // Simula carga inicial con skeleton
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _showSkeleton = false);
      }
    });
  }

  @override
  void dispose() {
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: _showSkeleton
          ? const Padding(
              padding: EdgeInsets.all(20),
              child: ResultadosSkeleton(), // placeholder
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ResultadosHeader(),
                  SizedBox(height: 24.h),

                  TicketDetalleWidget(
                    solicitud: widget.solicitud,
                    telefono: _telefonoController.text,
                  ),

                  SizedBox(height: 32.h),

                  Text(
                    'Proporciona un número telefónico',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  TextFormField(
                    controller: _telefonoController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.textPrimary(context),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: 'Teléfono',
                      labelStyle: AppTextStyles.inputLabel(context),
                      hintText: 'Ej. 7221234567',
                      hintStyle: AppTextStyles.inputHint(context),
                      prefixIcon: Icon(
                        Icons.phone_iphone_rounded,
                        size: 22.sp,
                        color: AppColors.primary,
                      ),
                      filled: true,
                      fillColor: AppColors.inputBackground(context),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white12
                              : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading
                          ? null
                          : () async {
                              setState(() => _loading = true);

                              await enviarContrato(
                                context: context,
                                user: widget.user,
                                solicitud: widget.solicitud,
                                telefono: _telefonoController.text.trim(),
                              );

                              if (mounted) {
                                setState(() => _loading = false);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: _loading
                          ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text('Mandar solicitud', style: AppTextStyles.buttonText(context)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
