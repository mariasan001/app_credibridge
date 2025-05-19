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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    solicitud
      ..tipoSimulacion = _tipoSeleccionado
      ..monto = _montoController.numberValue
      ..plazo = int.tryParse(_plazoController.text)
      ..descuento = widget.descuento;

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
  hintStyle: AppTextStyles.bodySmall(context).copyWith(
    color: AppColors.text(context),
  ),
  filled: true,
  fillColor: AppColors.inputBackground(context),
  prefixIcon: icon != null
      ? IconTheme(
          data: IconThemeData(color: AppColors.text(context)),
          child: icon,
        )
      : null,
  suffixText: suffix,
  suffixStyle: AppTextStyles.inputLabel(context),
  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.r),
    borderSide: BorderSide(
      color:AppColors.backgroundLight
    ),
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      closedColor: Colors.transparent,
      openBuilder:
          (context, _) => ResultadosSimulacionPage(
            user: widget.user,
            resultados: _resultados,
            solicitud: solicitud,
          ),
      closedBuilder: (context, openContainer) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.promoCardBackground(context),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow:
                Theme.of(context).brightness == Brightness.light
                    ? [
                      BoxShadow(
                        color: const Color.fromARGB(31, 238, 238, 238),
                        blurRadius: 10,
                        offset: Offset(0, 4.h),
                      ),
                    ]
                    : [],
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
                SizedBox(height: 24.h),
                Text(
                  _tipoSeleccionado?.id == 2
                      ? '¿Cuánto deseas que te descuenten por periodo?'
                      : '¿Cuál es la cantidad que deseas recibir?',
                  style: AppTextStyles.inputLabel(context),
                ),
                SizedBox(height: 8.h),
                if (_tipoSeleccionado?.id == 2 && widget.descuento != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
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
                  style: AppTextStyles.inputHint(
                    context,
                  ).copyWith(color: AppColors.text(context)),
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
                SizedBox(height: 20.h),
                Text(
                  '¿En cuántos plazos lo deseas?',
                  style: AppTextStyles.inputLabel(context),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _plazoController,
                  keyboardType: TextInputType.number,
                  decoration: _customInput(
                    hint: 'Número de plazos',
                    icon: const Icon(Icons.calendar_today_outlined),
                  ),
                  style: AppTextStyles.inputHint(
                    context,
                  ).copyWith(color: AppColors.text(context)),
                  validator: (value) {
                    final plazo = int.tryParse(value ?? '');
                    if (plazo == null || plazo < 1 || plazo > 96) {
                      return 'El plazo debe ser entre 1 y 96 meses';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _loading ? null : () => _handleSimular(openContainer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child:
                        _loading
                            ? SizedBox(
                              height: 22.h,
                              width: 22.w,
                              child: const CircularProgressIndicator(
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
