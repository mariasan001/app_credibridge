import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_service_tile.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class DirectorioGroupCard extends StatelessWidget {
  final LenderServiceGrouped group;
  final Function(LenderService) onTap;

  const DirectorioGroupCard({
    super.key,
    required this.group,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 160, 160, 160).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título del grupo (ej. PRÉSTAMOS, SEGUROS)
          Text(
            group.serviceTypeDesc,
            style: AppTextStyles.promoButtonText2(context),
          ),
          SizedBox(height: 12.h),

          // Lista de instituciones dentro del grupo
          ...group.services.mapIndexed((i, service) {
            return Column(
              children: [
                DirectorioServiceTile(
                  service: service,
                  onTap: () => onTap(service),
                ),
              
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
