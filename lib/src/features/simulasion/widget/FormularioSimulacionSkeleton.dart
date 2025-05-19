// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormularioSimulacionSkeleton extends StatelessWidget {
  const FormularioSimulacionSkeleton({super.key});

  Widget _shimmerBox({double height = 48, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height.h,
        width: width == double.infinity ? double.infinity : width.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2A2A2A)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(height: 14, width: 180), // 🏷️ Título selector
          SizedBox(height: 10.h),
          _shimmerBox(height: 48), // 🧩 Selector tipo

          SizedBox(height: 20.h),
          _shimmerBox(height: 14, width: 200), // 💸 Título monto
          SizedBox(height: 8.h),
          _shimmerBox(), // Campo monto

          SizedBox(height: 20.h),
          _shimmerBox(height: 14, width: 160), // 📆 Título plazos
          SizedBox(height: 8.h),
          _shimmerBox(), // Campo plazos

          SizedBox(height: 30.h),
          _shimmerBox(height: 48), // 🚀 Botón simular
        ],
      ),
    );
  }
}
