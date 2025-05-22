import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_request.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/page/resultados_simulacion_page.dart';
import 'package:app_creditos/src/features/simulasion/page/resultados_simulacion_skeleton.dart';
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
  SimType? _tipoSeleccionado;
  double _plazos = 12;
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
  }

  Future<void> _handleSimular() async {
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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: ResultadosSimulacionSkeleton()),
      ),
    );

    final request = SimulacionRequest(
      userId: widget.user.userId,
      simTypeId: _tipoSeleccionado!.id,
      periods: _plazos.round(),
      paymentAmount: _montoController.numberValue,
    );

    solicitud
      ..tipoSimulacion = _tipoSeleccionado
      ..monto = _montoController.numberValue
      ..plazo = _plazos.round()
      ..descuento = widget.descuento;

    try {
      final resultados = await _service.simularPrestamo(request);
      if (!context.mounted) return;

      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultadosSimulacionPage(
            user: widget.user,
            resultados: resultados,
            solicitud: solicitud,
          ),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al simular: $e')),
      );
    }
  }

InputDecoration _customInput({
  required String hint,
  String? suffix,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return InputDecoration(
    labelText: hint,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    labelStyle: AppTextStyles.bodySmall(context).copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.textMuted(context),
    ),
    filled: true,
    fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, // 💡 fondo claro puro
    suffixText: suffix,
    suffixStyle: AppTextStyles.bodySmall(context).copyWith(
      color: AppColors.textMuted(context),
      fontWeight: FontWeight.w600,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 1.4,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(
        color: Colors.red.shade400,
        width: 1.2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(
        color: Colors.red.shade600,
        width: 1.5,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
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
                  if (_tipoSeleccionado?.id == 2 && widget.descuento != null) {
                    _montoController.updateValue(widget.descuento!);
                  }
                });
              },
            ),
            SizedBox(height: 24.h),

            /// Monto
            Text(
              _tipoSeleccionado?.id == 2
                  ? '¿Cuánto deseas que te descuenten por periodo?'
                  : '¿Cuál es la cantidad que deseas recibir?',
              style: AppTextStyles.inputLabel(context),
            ),
            SizedBox(height: 12.h),
            if (_tipoSeleccionado?.id == 2 && widget.descuento != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  'Límite máximo: \$${widget.descuento!.toStringAsFixed(2)}',
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
                hint: _tipoSeleccionado?.id == 2
                    ? 'Cantidad a descontar'
                    : 'Cantidad a recibir',
                suffix: 'MXN',
              ),
              style: AppTextStyles.bodySmall(context).copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.text(context),
              ),
              validator: (value) {
                final amount = _montoController.numberValue;
                if (amount == 0) return 'Ingresa un monto válido';
                if (_tipoSeleccionado?.id == 2 && amount > widget.descuento!) {
                  return 'Supera tu límite disponible';
                }
                return null;
              },
            ),

            SizedBox(height: 28.h),

            /// Plazos
            Text(
              'Selecciona el número de plazos quincenales',
              style: AppTextStyles.inputLabel(context),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: AppColors.primary,
                overlayColor: AppColors.primary.withOpacity(0.2),
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Slider(
                    value: _plazos,
                    min: 1,
                    max: 96,
                    divisions: 95,
                    label: '${_plazos.round()} ',
                    onChanged: (value) {
                      setState(() {
                        _plazos = value;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${_plazos.round()} ',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleSimular,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),

                label: Text(
                  'Simular Préstamo',
                  style: AppTextStyles.buttonText(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
