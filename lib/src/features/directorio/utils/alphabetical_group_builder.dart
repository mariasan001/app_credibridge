import 'package:app_creditos/src/features/directorio/utils/lender_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';

List<Widget> buildAlphabeticalGroups({
  required LenderServiceGrouped group,
}) {
  final Map<String, List<LenderService>> porLetra = {};

  for (final service in group.services) {
    final letra = service.lender.lenderName.trim().isNotEmpty
        ? service.lender.lenderName.trim()[0].toUpperCase()
        : '#';
    porLetra.putIfAbsent(letra, () => []).add(service);
  }

  final letrasOrdenadas = porLetra.keys.toList()..sort();

  return letrasOrdenadas.map((letra) {
    final servicios = porLetra[letra]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
          child: Text(
            letra,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...servicios.map((service) => LenderCard(
          service: service,
          serviceType: group.serviceTypeDesc,
        )).toList(),
      ],
    );
  }).toList();
}
