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

  List<ContractModel> _ordenarContratos(List<ContractModel> lista) {
    final prestamos = lista.where((c) => c.serviceTypeDesc.toLowerCase().contains('préstamo')).toList();
    final seguros = lista.where((c) => c.serviceTypeDesc.toLowerCase().contains('seguro')).toList();
    final otros = lista.where((c) =>
      !c.serviceTypeDesc.toLowerCase().contains('préstamo') &&
      !c.serviceTypeDesc.toLowerCase().contains('seguro')
    ).toList();

    return [...prestamos, ...seguros, ...otros];
  }

  @override
  Widget build(BuildContext context) {
    final contratosActivos = contratos.where((c) => c.contractStatusDesc == 'ACTIVO').toList();

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
                                Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
                                SizedBox(width: 4.w),
                                Text('Mis servicios Activos', style: AppTextStyles.titleheader(context)),
                              ],
                            ),
                          ),
                          SizedBox(height: 6.h),
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ContratoDetalleWidget(contrato: contrato),
                                    SizedBox(height: 20.h),
                                    ResumenPagoCard(contrato: contrato),
                                    SizedBox(height: 30.h),
                                  ],
                                ),
                              ),
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
