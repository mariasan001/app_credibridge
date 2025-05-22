// ResultadosSimulacionSkeleton.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ResultadosSimulacionSkeleton extends StatelessWidget {
  const ResultadosSimulacionSkeleton({super.key});

  Widget _buildSkeletonBox({double height = 16, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkeletonBox(height: 20.h, width: 150.w),
              _buildSkeletonBox(height: 16.h),
              _buildSkeletonBox(height: 16.h, width: 200.w),
            ],
          ),
        ),
      ),
    );
  }
}
