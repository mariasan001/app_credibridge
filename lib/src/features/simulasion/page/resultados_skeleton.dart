import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultadosSkeleton extends StatelessWidget {
  const ResultadosSkeleton({super.key});

  Widget buildShimmerBox({double height = 16, double width = double.infinity, BorderRadius? radius}) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: radius ?? BorderRadius.circular(8.r),
      ),
    );
  }

  Widget buildTicketSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: List.generate(6, (i) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: buildShimmerBox(height: 16.h, width: i % 2 == 0 ? 220.w : 180.w),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            buildShimmerBox(height: 22.h, width: 180.w),
            buildShimmerBox(height: 18.h, width: 220.w),
            SizedBox(height: 24.h),

            // Sección tipo ticket
            buildTicketSection(),

            // Input teléfono
            buildShimmerBox(height: 18.h, width: 160.w),
            buildShimmerBox(height: 48.h, radius: BorderRadius.circular(14.r)),

            SizedBox(height: 32.h),

            // Botón
            buildShimmerBox(height: 48.h, width: double.infinity, radius: BorderRadius.circular(14.r)),
          ],
        ),
      ),
    );
  }
}
