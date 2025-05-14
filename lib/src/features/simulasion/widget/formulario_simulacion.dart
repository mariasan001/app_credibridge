import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_request.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/page/resultados_simulacion_page.dart';
import 'package:app_creditos/src/features/simulasion/services/simulacion_service.dart';
import 'package:app_creditos/src/features/simulasion/widget/selector_tipo_simulacion.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class FormularioSimulacion extends StatefulWidget {
  final User user;

  const FormularioSimulacion({super.key, required this.user});

  @override
  State<FormularioSimulacion> createState() => _FormularioSimulacionState();
}

class _FormularioSimulacionState extends State<FormularioSimulacion> {
  final _formKey = GlobalKey<FormState>();

  late MoneyMaskedTextController _montoController;
  late TextEditingController _plazoController;

  SimType? _tipoSeleccionado;
  bool _loading = false;
  List<SimulacionResult> _resultados = [];

  final SimulacionService _service = SimulacionService();

  @override
  void initState() {
    super.initState();

    _montoController = MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: ',',
      precision: 2,
      leftSymbol: '',
    );

    _plazoController = TextEditingController();
  }

  Future<void> _handleSimular(Function openContainer) async {
    if (!_formKey.currentState!.validate()) return;
    if (_tipoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un tipo de simulación')),
      );
      return;
    }
    setState(() => _loading = true);

    final request = SimulacionRequest(
      userId: widget.user.userId,
      simTypeId: _tipoSeleccionado!.id,
      periods: int.parse(_plazoController.text),
      paymentAmount: _montoController.numberValue,
    );

    try {
      final resultados = await _service.simularPrestamo(request);

      if (!context.mounted) return;

      setState(() => _resultados = resultados);
      openContainer();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al simular: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? suffixText,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.inputLabel(context),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      suffixStyle: AppTextStyles.promoListText(context),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.inputBorder(context)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.inputBorder(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.inputFocus, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      closedColor: Colors.transparent,
      openBuilder:
          (context, _) => ResultadosSimulacionPage(resultados: _resultados, user: widget.user, ),
      closedBuilder: (context, openContainer) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectorTipoSimulacion(
                  onChanged: (tipo) => _tipoSeleccionado = tipo,
                ),
                const SizedBox(height: 20),

                Text(
                  '¿Cuál es tu cantidad deseada?',
                  style: AppTextStyles.promoButtonText(context),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _montoController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration(
                    label: '',
                    prefixIcon: const Icon(Icons.attach_money_rounded),
                    suffixText: 'MEX',
                  ),
                  style: AppTextStyles.promoListText(context),
                  validator: (value) {
                    if (_montoController.numberValue == 0) {
                      return 'Ingresa un monto válido';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  '¿Cuántos plazos lo quieres?',
                  style: AppTextStyles.promoButtonText(context),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _plazoController,
                  keyboardType: TextInputType.number,

                  decoration: _inputDecoration(
                    label: '',
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                  style: AppTextStyles.promoListText(context),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa el plazo'
                              : null,
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _loading ? null : () => _handleSimular(openContainer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        _loading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Text(
                              'Simular Préstamo',
                              style: AppTextStyles.buttonText(context),
                            ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
