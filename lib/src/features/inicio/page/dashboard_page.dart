import 'dart:async';
import 'package:app_creditos/src/features/inicio/widget/mas_options_sheet.dart';
import 'package:app_creditos/src/features/inicio/widget/opicones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/features/inicio/service/descuento_service.dart';
import 'package:app_creditos/src/features/inicio/service/promociones_service.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/features/inicio/widget/descuento_card.dart';
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
  int _currentIndex = 0;

  // Carrusel
  late final PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  int _promocionesLength = 0;

  @override
  void initState() {
    super.initState();
    _cargarDescuento();
    _futurePromos = PromotionService.obtenerPromocionesActivas();

    _pageController = PageController(viewportFraction: 0.88);

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && mounted && _promocionesLength > 1) {
        if (_currentPage < (_promocionesLength - 1)) {
          _currentPage++;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          timer.cancel(); // Detiene el auto-scroll al llegar al final
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: CustomAppBar(user: widget.user),
      body: Stack(
        children: [
          // Fondo superior blanco con bordes redondeados
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.52,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // Contenido principal
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: kToolbarHeight + 68.h,
                      left: 16.w,
                      right: 16.w,
                      bottom: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        descuento == null
                            ? const DescuentoCardSkeleton()
                            : DescuentoCard(
                              descuento: descuento!,
                              user: widget.user,
                            ),
                        SizedBox(height: 44.h),
                        Text(
                          'Ofertas disponibles',
                          style: AppTextStyles.promoButtonText(
                            context,
                          ).copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),

                // Carrusel de promociones
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
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              'Error al cargar promociones: ${snapshot.error}',
                            ),
                          ),
                        );
                      }

                      final promociones = snapshot.data ?? [];
                      _promocionesLength = promociones.length;

                      if (promociones.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(14),
                          child:
                              SinPromocionesWidget(), // Aquí va el widget que tú defines
                        );
                      }

                      return SizedBox(
                        height: 200.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: promociones.length,
                          onPageChanged: (index) {
                            _currentPage = index;
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: PromocionCardCarrusel(
                                promo: promociones[index],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CapsuleBottomNavBar(
        selectedIndex: _currentIndex,
        onTabChanged: _onNavTap, user: widget.user, onLogout: () {  },
      ),
    );
  }
}
