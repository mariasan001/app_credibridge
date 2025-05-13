import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionesActivasWidget.dart';
import 'package:app_creditos/src/features/inicio/widget/descuento_card.dart';
import 'package:app_creditos/src/features/inicio/widget/nombre_formateado.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
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
            'Error del servidor: ${e.response?.data is Map ? e.response?.data['message'] : 'Sin detalles'}',
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              color: const Color(0xFFFCF8F2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.heading(context),
                      children: [
                        const TextSpan(text: 'Bienvenido '),
                        TextSpan(
                          text: '${obtenerNombreFormateado(widget.user.name)} ',
                          style: AppTextStyles.heading(context).copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(text: '👋'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gestiona tu cuenta de manera rápida y sencilla.',
                    style: AppTextStyles.bodySmall(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            descuento == null
                ? const DescuentoCardSkeleton()
                : DescuentoCard(descuento: descuento, user: widget.user),
            const SizedBox(height: 42),
            Text(
              'Promociones',
              style: AppTextStyles.heading(context).copyWith(fontSize: 20),
            ),
            const SizedBox(height: 16),
            const PromocionesActivasWidget(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
