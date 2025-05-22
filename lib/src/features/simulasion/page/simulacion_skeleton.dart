import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimulacionSkeleton extends StatelessWidget {
  const SimulacionSkeleton({super.key});

  Widget _buildBox({double height = 16, double width = double.infinity, EdgeInsets? margin}) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBox(height: 18.h, width: 140.w),
        _buildBox(height: 14.h, width: 220.w, margin: EdgeInsets.only(top: 4.h)),
      ],
    );
  }

  Widget _buildFormSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(4, (_) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBox(height: 12.h, width: 100.w),
                SizedBox(height: 6.h),
                _buildBox(height: 44.h),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCatSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBox(height: 14.h, width: 220.w),
          _buildBox(height: 14.h, width: 280.w),
          _buildBox(height: 14.h, width: 260.w),
          _buildBox(height: 14.h, width: 230.w),
          SizedBox(height: 12.h),
          _buildBox(height: 14.h, width: 160.w),
          _buildBox(height: 14.h, width: 180.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildHeader(),
          SizedBox(height: 32.h),
          _buildFormSection(),
          SizedBox(height: 32.h),
          _buildCatSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
