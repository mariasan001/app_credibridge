import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class EncabezadoHistorial extends StatelessWidget {
  final VoidCallback onVerTodos;

  const EncabezadoHistorial({super.key, required this.onVerTodos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Título + subtítulo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Historial',
                style: AppTextStyles.titleheader(context).copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
      
           
            ],
          ),

          // 🔸 Botón "ver todos"
          GestureDetector(
            onTap: onVerTodos,
            child: Row(
              children: [
                Text(
                  'ver todos',
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: const Color(0xFF746343),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward,
                  size: 16.sp,
                  color: const Color(0xFF746343),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
