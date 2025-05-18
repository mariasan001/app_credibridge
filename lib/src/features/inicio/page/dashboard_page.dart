import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';
import 'package:app_creditos/src/features/inicio/service/promociones_service.dart';
import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionesActivasWidget.dart';
import 'package:app_creditos/src/features/inicio/widget/descuento_card.dart';
import 'package:app_creditos/src/features/inicio/widget/nombre_formateado.dart';
import 'package:app_creditos/src/features/inicio/widget/sin_promociones_widget.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
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
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet    = screenWidth > 600;

  final horizontalPadding = isTablet ? 48.0 : 1.0;
  final verticalPadding   = isTablet ? 24.0 : 1.0;
  final headingFontSize   = isTablet ? 26.0 : 18.0;

  return Scaffold(
    backgroundColor: AppColors.background(context), 
    appBar: CustomAppBar(user: widget.user),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👋 Saludo
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 32 : 20,
              horizontal: isTablet ? 28 : 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.heading(context).copyWith(
                      fontSize: headingFontSize,
                    ),
                    children: [
                      const TextSpan(text: 'Bienvenido '),
                      TextSpan(
                        text: '${obtenerNombreFormateado(widget.user.name)} ',
                        style: AppTextStyles.heading(context).copyWith(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const TextSpan(text: '👋'),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Gestiona tu cuenta de manera rápida y sencilla.',
                  style: AppTextStyles.bodySmall(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🎯 Tarjeta de descuento
          descuento == null
              ? const DescuentoCardSkeleton()
              : DescuentoCard(descuento: descuento!, user: widget.user),

          const SizedBox(height: 20),

          // 📌 Título
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Promociones',
              style: AppTextStyles.heading(context).copyWith(
                fontSize: headingFontSize,
              ),
            ),
          ),
          const SizedBox(height: 3),

          //  Lista de promociones
          FutureBuilder<List<Promotion>>(
            future: PromotionService.obtenerPromocionesActivas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: const [
                    PromocionCardSkeleton(),
                    PromocionCardSkeleton(),
                    PromocionCardSkeleton(),
                  ],
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final promociones = snapshot.data ?? [];

              if (promociones.isEmpty) {
                return const SinPromocionesWidget();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: promociones.length,
                itemBuilder: (context, index) {
                  final promo = promociones[index];
                  return PromocionCardVisual(promo: promo);
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}
}