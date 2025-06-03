// chat_header_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/tiket_response_finaciera_model.dart';

class ChatHeader extends StatelessWidget {
  final TicketDetailModel ticket;
  const ChatHeader({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final isQueja = ticket.ticketType.toLowerCase().contains('queja');
    final tipoColor = isQueja ? Colors.red : Colors.blue;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: tipoColor.withOpacity(0.1),
          child: Icon(
            isQueja ? Icons.report_problem : Icons.chat_bubble_outline,
            color: tipoColor,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket.lenderName,
                style: AppTextStyles.promoBold(context).copyWith(fontSize: 14.sp, color: textColor),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(Icons.access_time, size: 12.sp, color: Colors.grey.shade500),
                  SizedBox(width: 4.w),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(ticket.creationDate),
                    style: AppTextStyles.bodySmall(context).copyWith(fontSize: 11.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: tipoColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            ticket.ticketType.toUpperCase(),
            style: AppTextStyles.promoButtonText(context).copyWith(
              fontSize: 10.sp,
              color: tipoColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}