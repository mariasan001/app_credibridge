
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HistorialSolicitudesSkeleton extends StatelessWidget {
  const HistorialSolicitudesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5, // cantidad de tarjetas fantasma
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 100.h,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14.h, width: 180.w, color: Colors.white),
                SizedBox(height: 8.h),
                Container(height: 12.h, width: 100.w, color: Colors.white),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 10.h, width: 60.w, color: Colors.white),
                    Container(height: 10.h, width: 80.w, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
