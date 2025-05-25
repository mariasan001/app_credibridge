import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MovimientoSkeletonCard extends StatelessWidget {
  const MovimientoSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSkeleton(context),
        SizedBox(height: 20.h),
        _buildBoxSkeletonDetalle(),
        SizedBox(height: 20.h),
        _buildBoxSkeletonResumen(),
      ],
    );
  }

  Widget _buildBoxSkeletonDetalle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20.h, width: 160.w, color: Colors.white),
            SizedBox(height: 8.h),
            Container(height: 12.h, width: 120.w, color: Colors.white),
            SizedBox(height: 16.h),
            Container(height: 40.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 10.h),
            Container(height: 12.h, width: 200.w, color: Colors.white),
            SizedBox(height: 16.h),
            Container(height: 36.h, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildBoxSkeletonResumen() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 16.h, width: 120.w, color: Colors.white),
            SizedBox(height: 20.h),
            Container(height: 40.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 16.h),
            Container(height: 16.h, width: 180.w, color: Colors.white),
            SizedBox(height: 16.h),
            Container(height: 36.h, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSkeleton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 180.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 240.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }
}
