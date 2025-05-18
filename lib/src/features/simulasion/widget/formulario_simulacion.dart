import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_request.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/page/resultados_simulacion_page.dart';
import 'package:app_creditos/src/features/simulasion/services/simulacion_service.dart';
import 'package:app_creditos/src/features/simulasion/widget/selector_tipo_simulacion.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class FormularioSimulacion extends StatefulWidget {
  final User user;
  final double? descuento;

  const FormularioSimulacion({
    super.key,
    required this.user,
    required this.descuento,
  });

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
  final SolicitudCreditoData solicitud = SolicitudCreditoData();

  @override
  void initState() {
    super.initState();
    _montoController = MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: ',',
      precision: 2,
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

    // Validación de descuento si el tipo es "por descuento"
    if (_tipoSeleccionado!.id == 2 &&
        widget.descuento != null &&
        _montoController.numberValue > widget.descuento!) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El monto excede tu límite de descuento disponible.'),
        ),
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

    // ✅ Guardar datos en el modelo de solicitud, incluyendo el descuento
solicitud
  ..tipoSimulacion = _tipoSeleccionado
  ..monto = _montoController.numberValue
  ..plazo = int.tryParse(_plazoController.text)
  ..descuento = widget.descuento; // ✅ ACTIVA esta línea

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

  InputDecoration _customInput({
    required String hint,
    Widget? icon,
    String? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF7F7F7),
      prefixIcon: icon,
      suffixText: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
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
      openBuilder: (context, _) => ResultadosSimulacionPage(
        user: widget.user,
        resultados: _resultados,
        solicitud: solicitud,
      ),
      closedBuilder: (context, openContainer) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
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
                  solicitudData: solicitud,
                  onChanged: (tipo) {
                    setState(() {
                      _tipoSeleccionado = tipo;
                      if (_tipoSeleccionado?.id == 2 &&
                          widget.descuento != null) {
                        _montoController.updateValue(widget.descuento!);
                      }
                    });
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  _tipoSeleccionado?.id == 2
                      ? '¿Cuánto deseas que te descuenten por periodo?'
                      : '¿Cuál es la cantidad que deseas recibir?',
                  style: AppTextStyles.inputLabel(context),
                ),
                const SizedBox(height: 8),
                if (_tipoSeleccionado?.id == 2 && widget.descuento != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Tu límite máximo de descuento es: \$${widget.descuento!.toStringAsFixed(2)}',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                TextFormField(
                  controller: _montoController,
                  keyboardType: TextInputType.number,
                  decoration: _customInput(
                    hint: 'Monto deseado',
                    icon: const Icon(Icons.attach_money_rounded),
                    suffix: 'MXN',
                  ),
                  style: AppTextStyles.linkMuted(context),
                  validator: (value) {
                    final amount = _montoController.numberValue;
                    if (amount == 0) return 'Ingresa un monto válido';
                    if (_tipoSeleccionado?.id == 2 &&
                        amount > widget.descuento!) {
                      return 'Supera tu límite de descuento disponible';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  '¿En cuántos plazos lo deseas?',
                  style: AppTextStyles.inputLabel(context),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _plazoController,
                  keyboardType: TextInputType.number,
                  decoration: _customInput(
                    hint: 'Número de plazos',
                    icon: const Icon(Icons.calendar_today_outlined),
                  ),
                  style: AppTextStyles.linkMuted(context),
                  validator: (value) {
                    final plazo = int.tryParse(value ?? '');
                    if (plazo == null || plazo < 1 || plazo > 96) {
                      return 'El plazo debe ser entre 1 y 96 meses';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _loading ? null : () => _handleSimular(openContainer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _loading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
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
