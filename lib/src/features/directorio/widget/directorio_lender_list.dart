import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/page/solicitud_page.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_group_card.dart';

class DirectorioServiceList extends StatelessWidget {
  final List<LenderServiceGrouped> groupedList;

  const DirectorioServiceList({
    super.key,
    required this.groupedList,
  });

  @override
  Widget build(BuildContext context) {
    return groupedList.isEmpty
        ? const Center(child: Text('No se encontraron resultados.'))
        : ListView.builder(
            padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
            itemCount: groupedList.length,
            itemBuilder: (context, index) {
              final group = groupedList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: DirectorioGroupCard(
                  group: group,
                  onTap: (service) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SolicitudPage(service: service),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
