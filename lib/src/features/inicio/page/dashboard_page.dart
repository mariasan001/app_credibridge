import 'package:app_creditos/src/features/inicio/widget/descuento_card.dart';
import 'package:app_creditos/src/features/inicio/widget/nombre_formateado.dart';
import 'package:app_creditos/src/features/inicio/widget/promocion_card.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/services/session_manager.dart';
import 'package:app_creditos/src/features/auth/page/login_page.dart';
import 'package:app_creditos/src/features/inicio/service/descuento_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? descuento;
  @override
  void initState() {
    super.initState();
    _cargarDescuento();
  }
Future<void> _cargarDescuento() async {
  try {
    final data = await DescuentoService.obtenerDescuento(widget.user.userId);

    if (!mounted) return;

    setState(() {
      descuento = data.amount;
    });
  } on DioException catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error del servidor: ${e.response?.data['message'] ?? 'Sin detalles'}',
        ),
      ),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e is String ? e : 'Error inesperado al obtener descuento',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(user: widget.user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido ${obtenerNombreFormateado(widget.user.name)} 👋',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Gestiona tu cuenta de manera rápida y sencilla.'),
            const SizedBox(height: 24),
            DescuentoCard(descuento: descuento, user: widget.user,),
            const SizedBox(height: 32),
            const Text(
              'Promociones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            buildPromocionCard(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  await SessionManager.clearToken();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  }
                },
                child: const Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
