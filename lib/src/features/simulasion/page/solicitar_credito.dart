import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animations/animations.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/models/contract_model.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/services/contact_service.dart';
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

  @override
  void dispose() {
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Solicitar Préstamo', style: AppTextStyles.titleheader(context).copyWith(fontSize: 18.sp)),
            SizedBox(height: 4.h),
            Text('Gestiona tu cuenta de manera rápida y sencilla.', style: AppTextStyles.bodySmall(context)),
            SizedBox(height: 24.h),

            /// Contenedor tipo ticket
            OpenContainer(
              closedElevation: 0,
              closedColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
              openBuilder: (_, __) => const SizedBox(),
              closedBuilder: (_, open) => InkWell(
                onTap: open,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.solicitud.lenderName ?? '-',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Divider(height: 32.h),
                      _dato(context, 'Valor descuento mensual', '\$${widget.solicitud.monto?.toStringAsFixed(2) ?? '-'}', isBold: true),
                      _dato(context, 'Tasa Efectivo (IVA incluido)', '${widget.solicitud.tasaPorPeriodo?.toStringAsFixed(2) ?? '-'}%', isLabelBold: true),
                      _dato(context, 'Tasa Efectiva Anual (IVA incluido)', '${widget.solicitud.tasaAnual?.toStringAsFixed(2) ?? '-'}%', isLabelBold: true),
                      Divider(height: 32.h),
                      _dato(context, 'Cantidad solicitada', '\$${widget.solicitud.capital?.toStringAsFixed(2) ?? '-'}', isBold: true, color: Colors.teal.shade600, big: true),
                      _dato(context, 'Cuotas', '${widget.solicitud.plazo ?? '-'}', isBold: true, color: Colors.orange.shade700, big: true),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h),

            Text('Proporciona un número telefónico', style: AppTextStyles.bodySmall(context).copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            TextFormField(
              controller: _telefonoController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: AppColors.text(context)),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone, size: 20.sp, color: Colors.grey),
                hintText: 'Ej. 7221234567',
                hintStyle: AppTextStyles.inputHint(context),
                filled: true,
                fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F3F3),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _enviarContrato,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                ),
                child: _loading
                    ? SizedBox(height: 20.h, width: 20.w, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Mandar solicitud', style: AppTextStyles.buttonText(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dato(
    BuildContext context,
    String label,
    String value, {
    Color? color,
    bool isBold = false,
    bool isLabelBold = false,
    bool big = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: isLabelBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              fontSize: big ? 16.sp : 14.sp,
              color: color ?? AppColors.text(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _enviarContrato() async {
    final telefono = _telefonoController.text.trim();

    if (telefono.isEmpty || telefono.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa un número válido.')),
      );
      return;
    }

    if (widget.solicitud.lenderId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ No se encontró la financiera seleccionada.')),
      );
      return;
    }

    final contrato = ContratoModel(
      lenderId: widget.solicitud.lenderId!,
      userId: widget.user.userId.toString(),
      contractType: widget.solicitud.tipoSimulacion?.id ?? 0,
      installments: widget.solicitud.plazo ?? 0,
      amount: widget.solicitud.capital ?? 0,
      monthlyDeductionAmount: widget.solicitud.monto?.round() ?? 0,
      effectiveRate: widget.solicitud.tasaPorPeriodo ?? 0,
      effectiveAnnualRate: widget.solicitud.tasaAnual ?? 0,
      phone: telefono,
    );

    setState(() => _loading = true);

    try {
      await ContractService.crearContrato(contrato);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Contrato enviado correctamente')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Error al enviar el contrato')),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }
}
