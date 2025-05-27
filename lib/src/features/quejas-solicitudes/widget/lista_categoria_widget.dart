import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_cat.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class ListaClarificationTypesWidget extends StatelessWidget {
  final List<ClarificationTypeModel> tipos;
  final void Function(ClarificationTypeModel) onTap;
  final ClarificationTypeModel? seleccionado;

  const ListaClarificationTypesWidget({
    super.key,
    required this.tipos,
    required this.onTap,
    this.seleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.inputBackground1(context),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tipos.length,
        separatorBuilder: (_, __) => SizedBox(width: 6.w),
        itemBuilder: (context, index) {
          final tipo = tipos[index];
          final isSelected = tipo.id == seleccionado?.id;

          return GestureDetector(
            onTap: () => onTap(tipo),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.cardtextfondo(context).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Text(
                tipo.clarificationTypeDesc,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? AppColors.cardtextfondo(context)
                      : AppColors.text(context).withOpacity(0.6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
