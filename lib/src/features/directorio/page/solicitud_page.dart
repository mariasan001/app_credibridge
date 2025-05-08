// solicitud_page.dart
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';

class SolicitudPage extends StatelessWidget {
  final LenderService service;

  const SolicitudPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.lender.lenderName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Correo: ${service.lender.lenderEmail}'),
            const SizedBox(height: 8),
            Text('Teléfono: ${service.lender.lenderPhone}'),
            const SizedBox(height: 16),
            Text('Tipo de servicio: ${service.serviceDesc}'),
            // Aquí puedes ir armando el formulario o info que necesites
          ],
        ),
      ),
    );
  }
}
