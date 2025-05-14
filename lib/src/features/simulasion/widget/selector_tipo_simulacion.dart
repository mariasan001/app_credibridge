// lib/src/features/simulacion/widgets/selector_tipo_simulacion.dart

import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/services/simulacion_service.dart';
import 'package:flutter/material.dart';

class SelectorTipoSimulacion extends StatefulWidget {
  final Function(SimType?)? onChanged;
  final SimType? initialValue;

  const SelectorTipoSimulacion({
    super.key,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<SelectorTipoSimulacion> createState() => _SelectorTipoSimulacionState();
}

class _SelectorTipoSimulacionState extends State<SelectorTipoSimulacion> {
  final SimulacionService _service = SimulacionService();
  late Future<List<SimType>> _futureTipos;
  SimType? _selectedTipo;

  @override
  void initState() {
    super.initState();
    _futureTipos = _service.obtenerTiposSimulacion();
    _selectedTipo = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimType>>(
      future: _futureTipos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error al cargar tipos: ${snapshot.error}');
        }

        final tipos = snapshot.data ?? [];

        return DropdownButtonFormField<SimType>(
          value: _selectedTipo,
          decoration: const InputDecoration(
            labelText: 'Tipo de Simulación',
            border: OutlineInputBorder(),
          ),
          items: tipos.map((tipo) {
            return DropdownMenuItem<SimType>(
              value: tipo,
              child: Text(tipo.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _selectedTipo = value);
            widget.onChanged?.call(value);
          },
        );
      },
    );
  }
}
