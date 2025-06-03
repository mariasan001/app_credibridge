import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class ChatInputFooter extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final String? nombreArchivo;
  final bool isSending;
  final VoidCallback? onRemoveFile;

  const ChatInputFooter({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttach,
    this.nombreArchivo,
    this.isSending = false,
    this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (nombreArchivo != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              margin: EdgeInsets.only(bottom: 6.h),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  const Icon(Icons.insert_drive_file, color: Colors.orange, size: 18),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      nombreArchivo!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                  if (onRemoveFile != null)
                    GestureDetector(
                      onTap: onRemoveFile,
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Icon(Icons.close, size: 16.sp, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: [
              GestureDetector(
                onTap: onAttach,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.attach_file, color: Colors.orange, size: 20.sp),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje...",
                    hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 42.h,
                width: 42.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: isSending
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 20),
                        onPressed: controller.text.trim().isNotEmpty || nombreArchivo != null
                            ? onSend
                            : null,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
