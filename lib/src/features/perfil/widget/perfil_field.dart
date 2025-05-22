// archivo: perfil_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class PerfilField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isEditing;
  final bool editable;
  final TextEditingController? controller;

  const PerfilField({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isEditing = false,
    this.editable = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isStatusField = label == 'Situación';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool showAsEditable = editable && isEditing;

    final TextEditingController _localController =
        controller ?? TextEditingController(text: value);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(icon, size: 18.sp, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted(context),
                    ),
                  ),
                ),
                if (isStatusField && value.toLowerCase().contains('activa'))
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else if (showAsEditable)
                  TextFormField(
                    controller: _localController,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text(context),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F3F3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                else
                  Text(
                    value.isNotEmpty ? value : '-',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text(context),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
