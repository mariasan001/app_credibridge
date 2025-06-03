import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ChatTicketSkeleton extends StatelessWidget {
  const ChatTicketSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;

    return Column(
      children: [
        // CONTENEDOR BLANCO QUE SIMULA EL CUADRO DE CONVERSACIÓN
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  if (theme.brightness == Brightness.light)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header simulado
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Burbujas del chat simuladas
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final isUser = index.isEven;
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8.h),
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                              constraints: BoxConstraints(maxWidth: 0.7.sw),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 12.h, width: 80.w, color: Colors.white),
                                  SizedBox(height: 6.h),
                                  Container(height: 10.h, width: 40.w, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // FOOTER SIMULADO (barra de escribir mensaje)
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 52.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
