import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';
import 'package:app_creditos/src/features/inicio/service/descuento_service.dart';
import 'package:app_creditos/src/features/inicio/service/promociones_service.dart';

import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/features/inicio/widget/descuento_card.dart';
import 'package:app_creditos/src/features/inicio/widget/nombre_formateado.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/PromocionesActivasWidget.dart';
import 'package:app_creditos/src/features/inicio/widget/DescuentoCardSkeleton.dart';
import 'package:app_creditos/src/features/inicio/widget/sin_promociones_widget.dart';

class HomePage extends StatefulWidget {
  final double? descuento;
  final ContractModel? contrato;
  final User user;
  const HomePage({super.key, required this.user, this.descuento, this.contrato, });

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
        setState(() {
          descuento = data.amount;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
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
                  Text.rich(
                    TextSpan(
                      style: AppTextStyles.heading(context).copyWith(fontSize: 22.sp),
                      children: [
                        const TextSpan(text: 'Bienvenido '),
                        TextSpan(
                          text: obtenerNombreFormateado(widget.user.name),
                          style: AppTextStyles.heading(context).copyWith(
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
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.textMuted(context),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 💸 Tarjeta descuento
                  descuento == null
                      ? const DescuentoCardSkeleton()
                      : DescuentoCard(descuento: descuento!, user: widget.user ),
                                        SizedBox(height: 32.h),

                  // 🏷️ Título de promociones
                  Text(
                    'Promociones',
                    style: AppTextStyles.heading(context).copyWith(fontSize: 22.sp),
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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: promociones.length,
                  itemBuilder: (_, i) => PromocionCardVisual(promo: promociones[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
