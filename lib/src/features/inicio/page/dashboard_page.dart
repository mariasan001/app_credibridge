import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
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

  const HomePage({
    super.key,
    required this.user,
    this.descuento,
    this.contrato,
  });

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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, ${obtenerNombreFormateado(widget.user.name)} 👋',
                    style: AppTextStyles.heading(context).copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    'Consulta y administra tus servicios.',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      fontSize: 13.sp,
                      color: AppColors.textMuted(context),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  descuento == null
                      ? const DescuentoCardSkeleton()
                      : DescuentoCard(descuento: descuento!, user: widget.user),

                  SizedBox(height: 24.h),

                  Text(
                    'Ofertas disponibles para ti',
                    style: AppTextStyles.heading(context).copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: FutureBuilder<List<Promotion>>(
              future: _futurePromos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        PromocionCardSkeleton(),
                        SizedBox(height: 12),
                        PromocionCardSkeleton(),
                        SizedBox(height: 12),
                        PromocionCardSkeleton(),
                      ],
                    ),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: promociones.length,
                  itemBuilder: (_, i) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: PromocionCardVisual(promo: promociones[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
