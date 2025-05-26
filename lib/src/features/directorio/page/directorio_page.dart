import 'package:app_creditos/src/features/directorio/page/solicitud_page.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/shared/theme/app_text_styles.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

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
      _filteredGrouped =
          _allGrouped
              .map((group) {
                final filteredServices =
                    group.services.where((item) {
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

  void _irAContacto(LenderService service) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SolicitudPage(service: service)),
    );
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
                  style: AppTextStyles.linkMuted(
                    context,
                  ).copyWith(color: Colors.red),
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
                  TextField(
                    onChanged: _onSearchChanged,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.text(context),
                    ),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      hintText: 'Buscar servicio o institución',
                      hintStyle: AppTextStyles.inputHint(context).copyWith(
                        fontSize: 13.sp,
                        color: AppColors.textMuted(context),
                      ),
                      prefixIcon: const Icon(Icons.search, size: 20),
                      filled: true,
                      fillColor:
                          isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  Expanded(
                    child:
                        _filteredGrouped.isEmpty
                            ? const Center(
                              child: Text('No se encontraron resultados.'),
                            )
                            : ListView.builder(
                              itemCount: _filteredGrouped.length,
                              itemBuilder: (context, index) {
                                final group = _filteredGrouped[index];

                                return Container(
                                  margin: EdgeInsets.only(bottom: 24.h),
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color:
                                        isDark
                                            ? const Color(0xFF1E1E1E)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(24.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.serviceTypeDesc,
                                        style: AppTextStyles.promoButtonText2(
                                          context,
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      ...group.services.map((service) {
                                        return GestureDetector(
                                          onTap: () => _irAContacto(service),
                                          child: Column(
                                            children: [
                                              Slidable(
                                                endActionPane: ActionPane(
                                                  motion: const DrawerMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed:
                                                          (_) => _irAContacto(
                                                            service,
                                                          ),
                                                      icon: Icons.chat,
                                                      backgroundColor:
                                                          Colors.green,
                                                      foregroundColor:
                                                          Colors.white,
                                                      label: 'Contactar',
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8.h,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 22.r,
                                                        backgroundColor:
                                                            Colors
                                                                .grey
                                                                .shade200,
                                                        child: Text(
                                                          service
                                                              .lender
                                                              .lenderName[0]
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16.sp,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 12.w),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                top: 2.h,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Tooltip(
                                                                message:
                                                                    service
                                                                        .lender
                                                                        .lenderName,
                                                                child: Text(
                                                                  service
                                                                      .lender
                                                                      .lenderName,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      AppTextStyles.bodySmall(
                                                                        context,
                                                                      ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2.h,
                                                              ),
                                                              Text(
                                                                service
                                                                    .lender
                                                                    .lenderEmail,
                                                                style:
                                                                    AppTextStyles.linkMuted(
                                                                      context,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                height: 2.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.phone,
                                                                    size: 14.sp,
                                                                    color:
                                                                        AppColors.textMuted(
                                                                          context,
                                                                        ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4.w,
                                                                  ),
                                                                  Text(
                                                                    service
                                                                        .lender
                                                                        .lenderPhone,
                                                                    style:
                                                                        AppTextStyles.linkMuted(
                                                                          context,
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
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12.h,
                                                ),
                                                child: DottedLine(
                                                  dashColor:
                                                      Colors.grey.shade300,
                                                  dashLength: 6,
                                                  lineThickness: 0.7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              },
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
