import 'package:app_creditos/src/features/movimientos/widget/encabezado_hisotrial.dart';
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
        contratos = result;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : contratos.isEmpty
              ? const Center(child: Text('No se encontraron contratos'))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔙 Encabezado
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 17.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Mis movimientos',
                                style: AppTextStyles.titleheader(context),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Consulta el estado de tus préstamos activos',
                          style: AppTextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                  ),

                  // 📲 Contenido deslizable
                  Expanded(
                    child: PageView.builder(
                      itemCount: contratos.length,
                      controller: PageController(viewportFraction: 0.95),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final contrato = contratos[index];
                        return AnimatedOpacity(
                          opacity: _showCards ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 1.w,
                              vertical: 1.h,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🧾 Contrato
                                  ContratoDetalleWidget(contrato: contrato),
                                  SizedBox(height: 20.h),

                                  // 🕓 Sección "Historial de pagos"
                                  EncabezadoHistorial(
                                    onVerTodos: () {
                                      // TODO: Acción al pulsar "ver todos"
                                      print('Ir a vista completa de historial');
                                    },
                                  ),

                                  SizedBox(height: 10.h),

                                  // 💳 Tarjeta resumen
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
