import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SimulacionPageSkeleton extends StatelessWidget {
  const SimulacionPageSkeleton({super.key});

  Widget _shimmerBox({
    double height = 48,
    double width = double.infinity,
    double radius = 12,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height.h,
        width: width == double.infinity ? width : width.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),

          // Título y subtítulo
          _shimmerBox(height: 24, width: 180),
          SizedBox(height: 8.h),
          _shimmerBox(height: 16, width: 260),

          SizedBox(height: 32.h),

          // Selector tipo simulación
          _shimmerBox(height: isTablet ? 56 : 48),
          SizedBox(height: 24.h),

          // Monto deseado
          _shimmerBox(height: 16, width: 200),
          SizedBox(height: 8.h),
          _shimmerBox(),

          SizedBox(height: 24.h),

          // Plazo
          _shimmerBox(height: 16, width: 180),
          SizedBox(height: 8.h),
          _shimmerBox(),

          SizedBox(height: 24.h),

          // Botón simular
          _shimmerBox(height: 48),

          SizedBox(height: 32.h),

          // Contenedor CAT
          _shimmerBox(height: 200, radius: 16),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
