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
      builder:
          (_) => const Scaffold(
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
          builder:
              (_) => ResultadosSimulacionPage(
                user: widget.user,
                resultados: resultados,
                solicitud: solicitud,
              ),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al simular: $e')));
    }
  }

  InputDecoration _customInput({required String hint, String? suffix}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
      fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF9F9F9),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),

      // 🏷️ Estilo del label/hint
      labelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.grey[400] : Colors.grey[700],
      ),
      hintStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.grey[500] : Colors.grey[600],
      ),

      // 📌 Sufijo (MXN)
      suffixText: suffix,
      suffixStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.grey[300] : Colors.grey[700],
      ),

      // 🧱 Bordes
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(
          color: const Color(0xFFFF944D), // color primario
          width: 1.8,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red.shade600, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow:
            Theme.of(context).brightness == Brightness.light
                ? [    
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
            // 🧾 Encabezado dinámico mejorado
            Text(
              _tipoSeleccionado?.id == 2
                  ? '¿Cuánto te gustaría que se descuente cada quincena?'
                  : '¿Cuánto dinero deseas solicitar?',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
              ),
            ),
            SizedBox(height: 10.h),

            // 🔒 Límite máximo visible
            if (_tipoSeleccionado?.id == 2 && widget.descuento != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  'Límite disponible: \$${widget.descuento!.toStringAsFixed(2)} MXN',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),

            // ✏️ Campo de monto
            TextFormField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              decoration: _customInput(
                hint:
                    _tipoSeleccionado?.id == 2
                        ? 'Ej. 1,200.00'
                        : 'Ej. 10,000.00',
                suffix: 'MXN',
              ),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
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
            Text(
              'Elige cuántos pagos quincenales deseas',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                      _plazos > 1 ? () => setState(() => _plazos--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.cuotasColor,
                  iconSize: 30.r,
                ),
                SizedBox(width: 20.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[850]
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${_plazos.round()} ${_plazos.round() == 1 ? 'plazo' : 'plazos'}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                IconButton(
                  onPressed:
                      _plazos < 96 ? () => setState(() => _plazos++) : null,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.cuotasColor,
                  iconSize: 30.r,
                ),
              ],
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
