import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

// Modelos y servicios
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';
import 'package:app_creditos/src/features/inicio/service/descuento_service.dart';
import 'package:app_creditos/src/features/inicio/service/promociones_service.dart';

// Widgets
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/features/inicio/widget/descuento_card.dart';
import 'package:app_creditos/src/features/inicio/widget/nombre_formateado.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionesActivasWidget.dart';
import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/sin_promociones_widget.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? descuento;
  late Future<List<Promotion>> _futurePromos;

  @override
  void initState() {
    super.initState();
    _cargarDescuento();
    _futurePromos = PromotionService.obtenerPromocionesActivas();
  }

  Future<void> _cargarDescuento() async {
    try {
      final data = await DescuentoService.obtenerDescuento(widget.user.userId);
      if (mounted) {
        descuento = data.amount;
        setState(() {});
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👋 Bienvenida
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.heading(
                        context,
                      ).copyWith(fontSize: 22.sp),
                      children: [
                        const TextSpan(text: 'Bienvenido '),
                        TextSpan(
                          text: obtenerNombreFormateado(widget.user.name),
                          style: AppTextStyles.heading(context).copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(text: ' 👋'),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Gestiona tu cuenta de manera rápida y sencilla.',
                    style: AppTextStyles.bodySmall(
                      context,
                    ).copyWith(color: AppColors.textMuted(context)),
                  ),

                  SizedBox(height: 20.h),

                  // 💸 Tarjeta de descuento
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        descuento == null
                            ? const DescuentoCardSkeleton()
                            : DescuentoCard(
                              descuento: descuento!,
                              user: widget.user,
                            ),
                  ),
                  SizedBox(height: 40.h),

                  // 🏷️ Título de promociones
                  Text(
                    'Promociones',
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontSize: 22.sp),
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          ),

          // 📦 Lista de promociones
          SliverToBoxAdapter(
            child: FutureBuilder<List<Promotion>>(
              future: _futurePromos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    children: [
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
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: promociones.length,
                  itemBuilder: (context, index) {
                    return PromocionCardVisual(promo: promociones[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
