import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/simulasion/model/sim_type_model.dart';
import 'package:app_creditos/src/features/simulasion/services/simulacion_service.dart';
import 'package:app_creditos/src/features/simulasion/utils/text_utils.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class SelectorTipoSimulacion extends StatefulWidget {
  final Function(SimType?)? onChanged;
  final SimType? initialValue;
  final SolicitudCreditoData solicitudData;

  const SelectorTipoSimulacion({
    super.key,
    required this.solicitudData,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<SelectorTipoSimulacion> createState() => _SelectorTipoSimulacionState();
}

class _SelectorTipoSimulacionState extends State<SelectorTipoSimulacion> {
  final SimulacionService _service = SimulacionService();
  late Future<List<SimType>> _futureTipos;
  SimType? _selectedTipo;

  @override
  void initState() {
    super.initState();
    _futureTipos = _service.obtenerTiposSimulacion();
    _selectedTipo = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimType>>(
      future: _futureTipos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              'Error al cargar tipos de simulación',
              style: AppTextStyles.bodySmall(
                context,
              ).copyWith(color: Colors.red),
            ),
          );
        }

        final tipos = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipo de simulación',
              style: AppTextStyles.heading(context).copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.background(context),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<SimType>(
                  value: _selectedTipo,
                  hint: Text(
                    'Selecciona tu tipo de simulación',
                    style: AppTextStyles.inputHint(context).copyWith(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[400]
                              : Colors.grey[700],
                    ),
                  ),

                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[300]
                            : Colors.grey[600],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  dropdownColor: AppColors.cardBackground(context),
                  itemHeight: 52.h,
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(color: AppColors.textPrimary(context)),
                  onChanged: (value) {
                    setState(() {
                      _selectedTipo = value;
                      widget.solicitudData.tipoSimulacion = value;
                      widget.onChanged?.call(value);
                    });
                  },
                  items:
                      tipos.map((tipo) {
                        return DropdownMenuItem<SimType>(
                          value: tipo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                capitalizarSoloPrimera(tipo.name),
                                style: TextStyle(
                                  color: AppColors.textPrimary(context),
                                ),
                              ),
                              if (_selectedTipo?.id == tipo.id)
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
