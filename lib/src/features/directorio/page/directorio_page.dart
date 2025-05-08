import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';

class DirectorioPage extends StatefulWidget {
  const DirectorioPage({super.key});

  @override
  State<DirectorioPage> createState() => _DirectorioPageState();
}

class _DirectorioPageState extends State<DirectorioPage> {
  late Future<List<LenderServiceGrouped>> _future;

  @override
  void initState() {
    super.initState();
    _future = DirectorioService.obtenerServiciosActivos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Directorio de Servicios')),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final grupo = data[index];

              return ExpansionTile(
                title: Text(grupo.serviceTypeDesc, style: const TextStyle(fontWeight: FontWeight.bold)),
                children: grupo.services.map((service) {
                  final lender = service.lender;
                  return ListTile(
                    title: Text(lender.lenderName),
                    subtitle: Text(lender.lenderPhone),
                    trailing: Icon(
                      Icons.check_circle,
                      color: lender.active ? Colors.green : Colors.grey,
                    ),
                    onTap: () {
                      // Aquí podrías ir a una vista detalle si quieres
                    },
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
