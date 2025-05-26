import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class DirectorioServiceTile extends StatelessWidget {
  final LenderService service;
  final VoidCallback onTap;

  const DirectorioServiceTile({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => onTap(),
                icon: Icons.chat,
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                label: 'Contactar',
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.grey.shade300,

                    child: Text(
                      service.lender.lenderName[0].toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tooltip(
                            message: service.lender.lenderName,
                            child: Text(
                              service.lender.lenderName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : AppColors.text(context),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            service.lender.lenderEmail,
                            style: AppTextStyles.linkMuted(context).copyWith(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : AppColors.text(context),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 14.sp,
                                color: AppColors.textMuted(context),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                service.lender.lenderPhone,
                                style: AppTextStyles.linkMuted(
                                  context,
                                ).copyWith(
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : AppColors.text(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: DottedLine(
            dashColor: Colors.grey.shade300,
            dashLength: 6,
            lineThickness: 0.7,
          ),
        ),
      ],
    );
  }
}
