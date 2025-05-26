import 'package:app_creditos/src/features/directorio/widget/directorio_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';

class LenderCard extends StatelessWidget {
  final LenderService service;
  final String serviceType;

  const LenderCard({
    super.key,
    required this.service,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final color = getColorForService(serviceType);
    final icon = getIconForService(serviceType);

    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 20.r,
            child: Icon(icon, color: Colors.white, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.lender.lenderName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  service.lender.lenderEmail,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  service.lender.lenderPhone,
                  style: TextStyle(fontSize: 12.sp, color: color),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
