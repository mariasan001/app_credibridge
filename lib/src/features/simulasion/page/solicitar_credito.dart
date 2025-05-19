import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/features/simulasion/widget/ticket_container.dart';
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
import 'package:intl/intl.dart';

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

final formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

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
    final isTipoDescuento = widget.solicitud.tipoSimulacion?.id == 1;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Solicitar Préstamo',
                          style: AppTextStyles.titleheader(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Gestiona tu cuenta de manera rápida y sencilla.',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.text(context), // ✅ color adaptativo
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            TicketContainer(
              backgroundColor: AppColors.cardBackground(context),
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 36.sp),
                  SizedBox(height: 8.h),
                  Text(
                    'Solicitud Exitosa',
                    style: AppTextStyles.titleheader(context),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    widget.solicitud.lenderName ?? '-',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.promoBold(
                      context,
                    ).copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    'Referencia automática',
                    style: AppTextStyles.bodySmall(
                      context,
                    ).copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 24.h),

                  _dottedDivider(context),
                  SizedBox(height: 8.h),

                  _dato(
                    context,
                    widget.solicitud.tipoSimulacion?.id == 1
                        ? 'Total solicitado'
                        : 'Valor de descuento quincenal',
                    '${formatCurrency.format(widget.solicitud.monto)} MXN',
                  ),

                  _dato(
                    context,
                    'Tasa x Periodo',
                    '${widget.solicitud.tasaPorPeriodo?.toStringAsFixed(2) ?? '-'}%',
                  ),
                  _dato(
                    context,
                    'Tasa Anual',
                    '${widget.solicitud.tasaAnual?.toStringAsFixed(2) ?? '-'}%',
                  ),

                  _dato(context, 'Plazos', '${widget.solicitud.plazo ?? '-'}'),
                  _dato(
                    context,
                    'Teléfono',
                    _telefonoController.text.isEmpty
                        ? '-'
                        : _telefonoController.text,
                  ),

                  SizedBox(height: 20.h),
                  _dottedDivider(context),
                  SizedBox(height: 10.h),

                  _dato(
                    context,
                    widget.solicitud.tipoSimulacion?.id == 1
                        ? 'Valor de descuento quincenal'
                        : 'Total solicitado',
                    widget.solicitud.capital != null
                        ? '${formatCurrency.format(widget.solicitud.capital)} MXN'
                        : '-',
                    isBold: true,
                    big: true,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
            Text(
              'Proporciona un número telefónico',
              style: AppTextStyles.bodySmall(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: _telefonoController,
              keyboardType: TextInputType.phone,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textPrimary(context),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
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
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white12
                            : Colors.grey.shade300,
                    width: 1,
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
                onPressed:
                    _loading
                        ? null
                        : () async {
                          await _enviarContrato();

                          if (mounted) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => HomePage(user: widget.user),
                              ),
                              (route) => false,
                            );
                          }
                        },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child:
                    _loading
                        ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(
                          'Mandar solicitud',
                          style: AppTextStyles.buttonText(context),
                        ),
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
                color: AppColors.textPrimary(context),
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              fontSize: big ? 16.sp : 14.sp,
              color: color ?? AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dottedDivider(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dotCount = (constraints.maxWidth / 12.w).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dotCount, (_) {
              return Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  color: AppColors.divider(context),
                  shape: BoxShape.circle,
                ),
              );
            }),
          );
        },
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
        const SnackBar(
          content: Text('❌ No se encontró la financiera seleccionada.'),
        ),
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
