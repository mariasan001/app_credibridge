import 'package:app_creditos/src/features/directorio/widget/directorio_lender_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_search_bar.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_skeleton.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';

class DirectorioPage extends StatefulWidget {
  final User user;
  const DirectorioPage({super.key, required this.user});

  @override
  State<DirectorioPage> createState() => _DirectorioPageState();
}

class _DirectorioPageState extends State<DirectorioPage> {
  late Future<List<LenderServiceGrouped>> _future;
  List<LenderServiceGrouped> _allGrouped = [];
  List<LenderServiceGrouped> _filteredGrouped = [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = _fetchData();
  }

  Future<List<LenderServiceGrouped>> _fetchData() async {
    final data = await DirectorioService.obtenerServiciosActivos();
    data.sort((a, b) => a.serviceTypeDesc.compareTo(b.serviceTypeDesc));
    return data;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _query = query.toLowerCase();
      _filteredGrouped = _allGrouped
          .map((group) {
            final filteredServices = group.services.where((item) {
              final name = item.lender.lenderName.toLowerCase();
              final desc = item.serviceDesc.toLowerCase();
              return name.contains(_query) || desc.contains(_query);
            }).toList();
            return LenderServiceGrouped(
              serviceTypeId: group.serviceTypeId,
              serviceTypeDesc: group.serviceTypeDesc,
              services: filteredServices,
            );
          })
          .where((group) => group.services.isNotEmpty)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: CustomAppBar(user: widget.user),
      body: SafeArea(
        child: FutureBuilder<List<LenderServiceGrouped>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const DirectorioSkeleton();
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Ocurrió un error al cargar el directorio',
                  style: AppTextStyles.linkMuted(context).copyWith(color: Colors.red),
                ),
              );
            }

            if (snapshot.hasData && _allGrouped.isEmpty) {
              _allGrouped = snapshot.data!;
              _filteredGrouped = _allGrouped;
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  DirectorioSearchBar(
                    isDark: isDark,
                    onChanged: _onSearchChanged,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: DirectorioServiceList(
                      groupedList: _filteredGrouped,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
