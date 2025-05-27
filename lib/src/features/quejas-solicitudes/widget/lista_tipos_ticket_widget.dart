import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_type_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListaTiposTicketWidget extends StatelessWidget {
  final List<TicketTypeModel> tipos;
  final TicketTypeModel? selectedTipo;
  final void Function(TicketTypeModel) onTap;

  const ListaTiposTicketWidget({
    super.key,
    required this.tipos,
    required this.selectedTipo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppColors.inputBackground1(context),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: tipos.map((tipo) {
          final isSelected = tipo.id == selectedTipo?.id;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(tipo),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.cardtextfondo(context)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.cardtextfondo(context).withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    tipo.ticketTypeDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : AppColors.text(context).withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
