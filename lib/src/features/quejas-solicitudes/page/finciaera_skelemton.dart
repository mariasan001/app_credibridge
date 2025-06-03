import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TicketFormSkeleton extends StatelessWidget {
  const TicketFormSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CONTENEDOR BLANCO DEL FORMULARIO
          Container(
            width: double.infinity,
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
              children: List.generate(6, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 46.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 28.h),

          // BOTÓN DE ENVIAR SIMULADO
          Shimmer.fromColors(
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

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
