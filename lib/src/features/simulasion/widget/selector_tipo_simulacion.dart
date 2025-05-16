import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:flutter/material.dart';
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
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Error al cargar tipos: ${snapshot.error}');
        }

        final tipos = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipo de simulación',
              style: AppTextStyles.heading(context).copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 246, 246),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Theme(
                data: Theme.of(context).copyWith(
                  cardTheme: CardTheme(
                    color: Colors.white,
                    elevation: 2,
                    shadowColor: const Color.fromARGB(135, 143, 143, 143).withOpacity(0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SimType>(
                    value: _selectedTipo,
                    hint: Text(
                      'Selecciona tu tipo de simulación',
                      style: AppTextStyles.promoListText(context).copyWith(color: Colors.grey),
                    ),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    menuMaxHeight: 220,
                    style: AppTextStyles.promoListText(context),
                    itemHeight: 48,
                    onChanged: (value) {
                      setState(() {
                        _selectedTipo = value;
                        widget.solicitudData.tipoSimulacion = value;
                        widget.onChanged?.call(value);
                      });
                    },
                    items: tipos.map((tipo) {
                      final isSelected = _selectedTipo?.id == tipo.id;
                      return DropdownMenuItem<SimType>(
                        value: tipo,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              capitalizarSoloPrimera(tipo.name),
                              style: AppTextStyles.bodySmall(context),
                            ),
                            if (isSelected)
                              const Icon(Icons.check, size: 16, color: AppColors.primary),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
