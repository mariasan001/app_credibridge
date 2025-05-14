import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_request.dart';
import 'package:app_creditos/src/features/simulasion/models/simulacion_result.dart';
import 'package:app_creditos/src/features/simulasion/page/resultados_simulacion_page.dart';
import 'package:app_creditos/src/features/simulasion/services/simulacion_service.dart';
import 'package:app_creditos/src/features/simulasion/widget/selector_tipo_simulacion.dart';

class FormularioSimulacion extends StatefulWidget {
  final User user;

  const FormularioSimulacion({super.key, required this.user});

  @override
  State<FormularioSimulacion> createState() => _FormularioSimulacionState();
}

class _FormularioSimulacionState extends State<FormularioSimulacion> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _plazoController = TextEditingController();
  SimType? _tipoSeleccionado;
  bool _loading = false;
  List<SimulacionResult> _resultados = [];

  final SimulacionService _service = SimulacionService();

  Future<void> _handleSimular(Function openContainer) async {
    if (!_formKey.currentState!.validate() || _tipoSeleccionado == null) return;

    setState(() => _loading = true);

    final request = SimulacionRequest(
      userId: widget.user.userId,
      simTypeId: _tipoSeleccionado!.id,
      periods: int.parse(_plazoController.text),
      paymentAmount: double.parse(_montoController.text),
    );

    try {
      final resultados = await _service.simularPrestamo(request);

      if (!context.mounted) return;

      setState(() => _resultados = resultados);
      openContainer(); // abre la transición animada
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al simular: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      closedColor: Colors.transparent,
      openBuilder: (context, _) => ResultadosSimulacionPage(resultados: _resultados),
      closedBuilder: (context, openContainer) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              SelectorTipoSimulacion(
                onChanged: (tipo) => _tipoSeleccionado = tipo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _montoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monto del Préstamo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el monto' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _plazoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Plazo en meses',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa el plazo' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loading ? null : () => _handleSimular(openContainer),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simular'),
              ),
            ],
          ),
        );
      },
    );
  }
}
