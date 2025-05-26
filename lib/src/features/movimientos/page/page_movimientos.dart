import 'package:app_creditos/src/features/movimientos/page/page_movimiento_skeleton.dart';
import 'package:app_creditos/src/features/movimientos/widget/resumen_pago_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/features/solicitudes/services/contract_service.dart';
import 'package:app_creditos/src/features/movimientos/widget/contrato_detalle_widget.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    cargarContratos();
  }

  Future<void> cargarContratos() async {
    try {
      final result = await ContractService.getContractsByUser(
        widget.user.userId,
      );
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

  return !esSeguro && (esPrestamoTexto || (montoValido && tienePagos && tieneDescuento && tieneSaldos));
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
      appBar: CustomAppBar(user: widget.user),
      body: loading
          ? const MovimientoSkeletonCard()
          : contratosActivos.isEmpty
              ? const Center(child: Text('No se encontraron contratos activos'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(8.r),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Mis servicios activos',
                                  style: AppTextStyles.titleheader(context),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Desliza para ver los demás servicios ${_currentIndex + 1} de ${contratosActivos.length}',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: contratosActivos.length,
                        controller: PageController(viewportFraction: 0.95),
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final contrato = contratosActivos[index];
                          return AnimatedOpacity(
                            opacity: _showCards ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ContratoDetalleWidget(contrato: contrato),
                                  SizedBox(height: 20.h),
                                  ResumenPagoCard(contrato: contrato, user: widget.user),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(contratosActivos.length, (index) {
                        final isActive = index == _currentIndex;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: isActive ? 16.w : 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.orange : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
    );
  }
}
