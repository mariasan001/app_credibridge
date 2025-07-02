import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/inicio/widget/opicones.dart';
import 'package:app_creditos/src/features/movimientos/widget/resumen_pago_card.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/features/solicitudes/services/contract_service.dart';
import 'package:app_creditos/src/features/movimientos/widget/contrato_detalle_widget.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';

class PageMovimientos extends StatefulWidget {
  final User user;

  const PageMovimientos({super.key, required this.user});

  @override
  State<PageMovimientos> createState() => _PageMovimientosState();
}

class _PageMovimientosState extends State<PageMovimientos> {
  List<ContractModel> contratos = [];
  bool loading = true;
  bool _showCards = false;

  int _currentSlideIndex = 0;     // Carrusel
  int _selectedNavIndex = 0;      // BottomNavBar

  PageController? _pageController;
  Timer? _autoPageTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
    cargarContratos();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoPageTimer?.cancel();
    _autoPageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController != null && contratos.isNotEmpty) {
        int nextPage = (_currentSlideIndex + 1) % contratos.length;
        _pageController!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseAutoScroll() {
    _autoPageTimer?.cancel();
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _autoPageTimer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  Future<void> cargarContratos() async {
    try {
      final result = await ContractService.getContractsByUser(widget.user.userId);
      setState(() {
        contratos = _ordenarContratos(result);
        loading = false;
        _showCards = true;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar contratos')),
      );
    }
  }

  bool esPosiblePrestamo(ContractModel contrato) {
    final tipo = contrato.serviceTypeDesc.toLowerCase();
    final esSeguro = tipo.contains('seguro');
    final esPrestamoTexto = tipo.contains('préstamo') || tipo.contains('prestamo');
    final montoValido = contrato.amount > 1000;
    final tienePagos = contrato.installments > 1;
    final tieneDescuento = contrato.biweeklyDiscount > 0 && contrato.biweeklyDiscount < 5000;
    final tieneSaldos = contrato.lastBalance > 0 || contrato.newBalance > 0;

    return !esSeguro &&
        (esPrestamoTexto ||
            (montoValido && tienePagos && tieneDescuento && tieneSaldos));
  }

  List<ContractModel> _ordenarContratos(List<ContractModel> lista) {
    final prestamos = <ContractModel>[];
    final seguros = <ContractModel>[];
    final otros = <ContractModel>[];

    for (var contrato in lista) {
      final tipo = contrato.serviceTypeDesc.toLowerCase();
      if (esPosiblePrestamo(contrato)) {
        prestamos.add(contrato);
      } else if (tipo.contains('seguro')) {
        seguros.add(contrato);
      } else {
        otros.add(contrato);
      }
    }

    return [...prestamos, ...seguros, ...otros];
  }

  @override
  Widget build(BuildContext context) {
    final contratosActivos =
        contratos.where((c) => c.contractStatusDesc == 'ACTIVO').toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.fondoPrimary(context),
      appBar: CustomAppBar(user: widget.user),

      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 430.h,
                    child: GestureDetector(
                      onTapDown: (_) => _pauseAutoScroll(),
                      onHorizontalDragStart: (_) => _pauseAutoScroll(),
                      child: PageView.builder(
                        itemCount: contratosActivos.length,
                        controller: _pageController,
                        onPageChanged: (index) {
                          HapticFeedback.selectionClick(); // vibración leve
                          setState(() {
                            _currentSlideIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final contrato = contratosActivos[index];
                          return AnimatedOpacity(
                            opacity: _showCards ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: Padding(
                              padding: EdgeInsets.only(top: kToolbarHeight + 42.h),
                              child: ContratoDetalleWidget(
                                contrato: contrato,
                                isActive: index == _currentSlideIndex,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (contratosActivos.isNotEmpty)
                          ResumenPagoCard(
                            contrato: contratosActivos[_currentSlideIndex],
                            user: widget.user,
                          ),
                        SizedBox(height: 42.h),
                        if (contratosActivos.length > 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              contratosActivos.length,
                              (index) {
                                final isActive = index == _currentSlideIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                  width: isActive ? 16.w : 8.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? const Color.fromARGB(255, 231, 144, 14)
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ✅ Barra fija e independiente del carrusel
      bottomNavigationBar: CapsuleBottomNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        user: widget.user,
        onLogout: () {},
      ),
    );
  }
}
