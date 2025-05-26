import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DirectorioSkeleton extends StatelessWidget {
  const DirectorioSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de búsqueda skeleton
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        ),
        // Lista de tarjetas
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 140.w,
                          height: 14.h,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20.h),
                        _buildItem(),
                        SizedBox(height: 12.h),
                        Divider(color: Colors.grey.shade300, thickness: 1),
                        SizedBox(height: 12.h),
                        _buildItem(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 12.h,
                color: Colors.white,
              ),
              SizedBox(height: 6.h),
              Container(
                width: 150.w,
                height: 10.h,
                color: Colors.white,
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    width: 100.w,
                    height: 10.h,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
