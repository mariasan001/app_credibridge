import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/solicitudes/model/contract_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/simulasion/widget/ticket_container.dart';

class SolicitudCard extends StatelessWidget {
  final ContractModel contrato;

  const SolicitudCard({super.key, required this.contrato});

  String formatCurrency(double? value) {
    final formatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return formatter.format(value ?? 0);
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '---';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  Color getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    switch (status.toUpperCase()) {
      case 'Activo':
        return AppColors.iconColorStrong;
      case 'Reserva':
        return const Color.fromARGB(255, 55, 55, 55);
      case 'Rechazado':
        return AppColors.iconColorStrong;
      default:
        return AppColors.iconColorStrong;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.h),
      child: TicketContainer(
        radius: 12.r,
        backgroundColor: AppColors.cardBackground(context),
        child: Column(
          children: [
            // Encabezado
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Center(
                child: Text(
                  'SOLICITUD #${contrato.id}',
                  style: AppTextStyles.promoTitle(context),
                ),
              ),
            ),
            _buildDottedLine(),
            // Detalles
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Wrap(
                spacing: 15.w,
                runSpacing: 12.h,
                alignment: WrapAlignment.center,
                children: [
                  _buildMiniDetail(context, "Plazos", "${contrato.installments ?? '--'} meses"),
                  _buildMiniDetail(context, "Tasa efectiva", contrato.effectiveRate != null ? "${contrato.effectiveRate!.toStringAsFixed(2)}%" : '---'),
                  _buildMiniDetail(context, "Monto", formatCurrency(contrato.amount)),
                  _buildMiniDetail(context, "Tasa anual", contrato.anualRate != null ? "${contrato.anualRate!.toStringAsFixed(2)}%" : '---'),
                  _buildMiniDetail(context, "Descuento", formatCurrency(contrato.monthlyDeductionAmount)),
                  _buildMiniDetail(context, "Creado", formatDate(contrato.createdAt)),
                ],
              ),
            ),

            _buildDottedLine(),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    contrato.contractStatusDesc?.toUpperCase() ?? 'SIN ESTATUS',
                    style: AppTextStyles.promoBold(context).copyWith(
                  
                      color: getStatusColor(contrato.contractStatusDesc),
                    
                    ),
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    color: getStatusColor(contrato.contractStatusDesc),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniDetail(BuildContext context, String label, String value) {
    return SizedBox(
      width: 140.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTextStyles.bodySmall(context).copyWith(
              fontSize: 11.sp,
              letterSpacing: 0.5,
              color: AppColors.textMuted(context),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyles.promoBold(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedLine() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dashWidth = 4.0;
          final dashHeight = 0.8;
          final dashCount = (constraints.maxWidth / (dashWidth * 2)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              dashCount,
              (_) => Container(
                width: dashWidth,
                height: dashHeight,
                color: AppColors.divider(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
