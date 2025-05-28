import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/page/chat_tiket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/quejas-solicitudes/model/ticket_historial_model.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class TicketCard extends StatelessWidget {
  final TicketHistorialModel ticket;
  final User user;

  const TicketCard({super.key, required this.ticket, required this.user});

  @override
  Widget build(BuildContext context) {
    final isQueja = ticket.ticketType.toLowerCase().contains('queja');
    final tipoColor = isQueja ? Colors.red : Colors.blue;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => ChatTicketPage(ticketId: ticket.ticketId, user: user),
          ),
        );
      },

      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: tipoColor.withOpacity(0.1),
                  child: Icon(
                    isQueja ? Icons.report_problem : Icons.chat_bubble_outline,
                    color: tipoColor,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.lenderName,
                        style: AppTextStyles.promoBold(context),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        ticket.creationDate.toLocal().toString().substring(
                          0,
                          16,
                        ),
                        style: AppTextStyles.bodySmall(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: tipoColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    ticket.ticketType.toUpperCase(),
                    style: AppTextStyles.promoButtonText(context).copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: tipoColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            /// MENSAJE
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.inputBackground1(context),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 18.sp,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      ticket.subject,
                      style: AppTextStyles.promoBody(context),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            /// ESTATUS
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color:
                      ticket.status.toLowerCase() == 'resuelto'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  ticket.status.toUpperCase(),
                  style: AppTextStyles.promoButtonText(context).copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        ticket.status.toLowerCase() == 'resuelto'
                            ? Colors.green
                            : Colors.orange.shade700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
