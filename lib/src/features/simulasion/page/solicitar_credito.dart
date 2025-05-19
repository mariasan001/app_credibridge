import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/simulasion/models/contract_model.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/services/contact_service.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
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
    final bool esTipo1 = widget.solicitud.tipoSimulacion?.id == 1;
    final String montoLabel = esTipo1 ? 'Monto solicitado' : 'Descuento quincenal';
    final String capitalLabel = esTipo1 ? 'Descuento quincenal' : 'Monto otorgado';

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: Padding(
        padding: EdgeInsets.all(24.w),
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
                  Text('Simulación', style: AppTextStyles.titleheader(context)),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Estos son los datos que seleccionaste:',
              style: AppTextStyles.bodySmall(context),
            ),
            SizedBox(height: 24.h),

            _buildDato(context, 'Tipo de simulación', widget.solicitud.tipoSimulacion?.name ?? '-'),
            _buildDato(context, montoLabel, '\$${widget.solicitud.monto?.toStringAsFixed(2) ?? '-'}'),
            _buildDato(context, 'Plazo', '${widget.solicitud.plazo ?? '-'} meses'),
            _buildDato(context, 'Tasa anual', '${widget.solicitud.tasaAnual?.toStringAsFixed(2) ?? '-'}%'),
            _buildDato(context, 'Tasa x periodo', '${widget.solicitud.tasaPorPeriodo?.toStringAsFixed(2) ?? '-'}%'),
            _buildDato(context, 'Nombre Financiera', widget.solicitud.lenderName ?? '-'),
            _buildDato(context, capitalLabel, '\$${widget.solicitud.capital?.toStringAsFixed(2) ?? '-'}'),

            SizedBox(height: 24.h),
            Text(
              'Número telefónico:',
              style: AppTextStyles.bodySmall(context).copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _telefonoController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Ej. 7221234567',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Botón enviar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _enviarContrato,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _loading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text('Solicitar crédito', style: AppTextStyles.buttonText(context)),
              ),
            ),
          ],
        ),
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Contrato enviado correctamente')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Error al enviar el contrato')),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildDato(BuildContext context, String titulo, String valor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: AppTextStyles.bodySmall(context)),
          Text(valor, style: AppTextStyles.bodySmall(context)),
        ],
      ),
    );
  }
}
