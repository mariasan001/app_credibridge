import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'dato.dart';
import 'dotted_divider.dart';
import 'package:app_creditos/src/features/simulasion/models/solicitud_credito_data.dart';
import 'package:app_creditos/src/features/simulasion/widget/ticket_container.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

final formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

class TicketDetalleWidget extends StatelessWidget {
  final SolicitudCreditoData solicitud;
  final String telefono;

  const TicketDetalleWidget({
    super.key,
    required this.solicitud,
    required this.telefono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TicketContainer(
        radius: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 36.sp),
            SizedBox(height: 8.h),
            Text('Solicitud Exitosa', style: AppTextStyles.titleheader(context)),
            SizedBox(height: 6.h),

            Text(
              solicitud.lenderName ?? '-',
              textAlign: TextAlign.center,
              style: AppTextStyles.promoBold(context).copyWith(fontSize: 16.sp),
            ),

            Text(
              'Referencia automática',
              style: AppTextStyles.bodySmall(context).copyWith(color: Colors.grey),
            ),

            SizedBox(height: 24.h),
            const DottedDivider(),
            SizedBox(height: 8.h),

            // Datos del contrato
            Dato(
              label: solicitud.tipoSimulacion?.id == 1
                  ? 'Total solicitado'
                  : 'Valor de descuento quincenal',
              value: '${formatCurrency.format(solicitud.monto)} MXN',
            ),
            Dato(
              label: 'Tasa x Periodo',
              value: '${solicitud.tasaPorPeriodo?.toStringAsFixed(2) ?? '-'}%',
            ),
            Dato(
              label: 'Tasa Anual',
              value: '${solicitud.tasaAnual?.toStringAsFixed(2) ?? '-'}%',
            ),
            Dato(
              label: 'Plazos',
              value: '${solicitud.plazo ?? '-'}',
            ),
            Dato(
              label: 'Teléfono',
              value: telefono.isEmpty ? '-' : telefono,
            ),

            SizedBox(height: 20.h),
            const DottedDivider(),
            SizedBox(height: 10.h),

            // Total o descuento final
            Dato(
              label: solicitud.tipoSimulacion?.id == 1
                  ? 'Valor de descuento quincenal'
                  : 'Total solicitado',
              value: solicitud.capital != null
                  ? '${formatCurrency.format(solicitud.capital)} MXN'
                  : '-',
              isBold: true,
              big: true,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
