import 'package:app_creditos/src/features/movimientos/widget/cuota_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResumenCuotas extends StatelessWidget {
  final int total;
  final int actual;
  final int restantes;

  const ResumenCuotas({super.key, required this.total, required this.actual, required this.restantes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CuotaCard(value: total, label: "cuotas totales"),
          CuotaCard(value: actual, label: "cuota actual"),
          CuotaCard(value: restantes, label: "cuotas restantes"),
        ],
      ),
    );
  }
}
