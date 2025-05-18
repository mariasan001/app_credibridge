import 'package:app_creditos/src/features/simulasion/models/contract_model.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/services/contact_service.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:flutter/material.dart';
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
    final String montoLabel =
        esTipo1 ? 'Monto solicitado' : 'Descuento quincenal';
    final String capitalLabel =
        esTipo1 ? 'Descuento quincenal' : 'Monto otorgado';

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  const SizedBox(width: 4),
                  Text('Simulación', style: AppTextStyles.titleheader(context)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Estos son los datos que seleccionaste:',
              style: AppTextStyles.bodySmall(context),
            ),
            const SizedBox(height: 24),

            _buildDato(
              context,
              'Tipo de simulación',
              widget.solicitud.tipoSimulacion?.name ?? '-',
            ),
            _buildDato(
              context,
              montoLabel,
              '\$${widget.solicitud.monto?.toStringAsFixed(2) ?? '-'}',
            ),
            _buildDato(
              context,
              'Plazo',
              '${widget.solicitud.plazo ?? '-'} meses',
            ),
            _buildDato(
              context,
              'Tasa anual',
              '${widget.solicitud.tasaAnual?.toStringAsFixed(2) ?? '-'}%',
            ),
            _buildDato(
              context,
              'Tasa x periodo',
              '${widget.solicitud.tasaPorPeriodo?.toStringAsFixed(2) ?? '-'}%',
            ),
            _buildDato(
              context,
              'Nombre Financiera',
              widget.solicitud.lenderName ?? '-',
            ),
            _buildDato(
              context,
              capitalLabel,
              '\$${widget.solicitud.capital?.toStringAsFixed(2) ?? '-'}',
            ),

            const SizedBox(height: 24),
            Text(
              'Número telefónico:',
              style: AppTextStyles.bodySmall(context).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _telefonoController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Ej. 7221234567',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading
                    ? null
                    : () async {
                        final telefono = _telefonoController.text.trim();

                        // ✅ Validar número
                        if (telefono.isEmpty || telefono.length < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor ingresa un número válido.'),
                            ),
                          );
                          return;
                        }

                        // ✅ Validar lenderId no sea null
                        if (widget.solicitud.lenderId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('❌ No se encontró la financiera seleccionada.'),
                            ),
                          );
                          return;
                        }

                        // ✅ Crear contrato con mapeo correcto
                        final contrato = ContratoModel(
                          lenderId: widget.solicitud.lenderId!, // financiera
                          userId: widget.user.userId.toString(), // usuario
                          contractType: widget.solicitud.tipoSimulacion?.id ?? 0,
                          installments: widget.solicitud.plazo ?? 0,
                          amount: widget.solicitud.capital ?? 0,
                          monthlyDeductionAmount:
                              widget.solicitud.monto?.round() ?? 0,
                          effectiveRate: widget.solicitud.tasaPorPeriodo ?? 0,
                          effectiveAnnualRate: widget.solicitud.tasaAnual ?? 0,
                          phone: telefono,
                        );

                        print('📤 Enviando contrato: ${contrato.toJson()}');

                        setState(() => _loading = true);

                        try {
                          await ContractService.crearContrato(contrato);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('✅ Contrato enviado correctamente'),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('❌ Error al enviar el contrato'),
                              ),
                            );
                          }
                        } finally {
                          setState(() => _loading = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Solicitar crédito',
                        style: AppTextStyles.buttonText(context),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDato(BuildContext context, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
