import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class SolicitudCardSkeleton extends StatelessWidget {
  const SolicitudCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            _skeletonLine(width: 180.w, height: 20.h),
            SizedBox(height: 16.h),
            _skeletonLine(width: double.infinity, height: 1.5.h),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 15.w,
              runSpacing: 12.h,
              alignment: WrapAlignment.center,
              children: List.generate(6, (_) => _detailPlaceholder()),
            ),
            SizedBox(height: 16.h),
            _skeletonLine(width: double.infinity, height: 1.5.h),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _skeletonLine(width: 100.w, height: 14.h),
                _circle(height: 20.r),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }

  Widget _circle({required double height}) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _detailPlaceholder() {
    return SizedBox(
      width: 140.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _skeletonLine(width: 100.w, height: 10.h),
          SizedBox(height: 4.h),
          _skeletonLine(width: 90.w, height: 12.h),
        ],
      ),
    );
  }
}
