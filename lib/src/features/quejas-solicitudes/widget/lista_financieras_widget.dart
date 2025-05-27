import 'package:app_creditos/src/features/quejas-solicitudes/model/lender_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListaFinancierasWidget extends StatelessWidget {
  final List<LenderModel> financieras;
  final LenderModel? selectedLender;
  final void Function(LenderModel) onTap;

  const ListaFinancierasWidget({
    super.key,
    required this.financieras,
    required this.selectedLender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _mostrarSelector(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.inputBackground2(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.inputBorder(context), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedLender?.lenderName ?? 'Selecciona una financiera',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text(context),
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.text(context).withOpacity(0.5)),
          ],
        ),
      ),
    );
  }

  void _mostrarSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.65,
          minChildSize: 0.4,
          initialChildSize: 0.55,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground(context), // se adapta a modo oscuro
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selecciona una financiera',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(height: 1, color: AppColors.inputBorder(context)),
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
                      ),
                      itemCount: financieras.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: AppColors.inputBorder(context)),
                      itemBuilder: (_, index) {
                        final lender = financieras[index];
                        final isSelected = lender.id == selectedLender?.id;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            tileColor: isSelected
                                ? AppColors.cardtextfondo(context).withOpacity(0.08)
                                : Colors.transparent,
                            title: Text(
                              lender.lenderName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: isSelected
                                    ? AppColors.cardtextfondo(context)
                                    : AppColors.text(context),
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(Icons.check,
                                    color: AppColors.cardtextfondo(context))
                                : null,
                            onTap: () {
                              Navigator.pop(context);
                              onTap(lender);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
