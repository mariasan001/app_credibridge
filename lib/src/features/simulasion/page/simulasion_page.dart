import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/simulasion/widget/formulario_simulacion.dart';
import 'package:flutter/material.dart';

// SimulacionPage
class SimulacionPage extends StatelessWidget {
  final User user;
  const SimulacionPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulación de Préstamo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormularioSimulacion(user: user),
      ),
    );
  }
}
