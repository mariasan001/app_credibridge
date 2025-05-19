import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_menu.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_skeleton.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_utils.dart';
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
    return await DirectorioService.obtenerServiciosActivos();
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
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(user: widget.user),
      body: SafeArea(
        child: FutureBuilder<List<LenderServiceGrouped>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 6,
                itemBuilder: (_, __) => const LenderCardSkeleton(),
              );
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

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Directorio', style: AppTextStyles.titleheader(context)),
                              Text('Consulta servicios disponibles', style: AppTextStyles.promoListText(context)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      TextField(
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Buscar servicio o institución',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: AppTextStyles.inputHint(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: _filteredGrouped.isEmpty
                      ? Center(
                          child: Text('No se encontraron resultados.', style: AppTextStyles.linkMuted(context)),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _filteredGrouped.length,
                          itemBuilder: (context, index) {
                            final group = _filteredGrouped[index];
                            final color = getColorForService(group.serviceTypeDesc);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 14.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Text(
                                    group.serviceTypeDesc.toUpperCase(),
                                    style: AppTextStyles.linkBold(context).copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.sp,
                                      color: isDark ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                ...group.services.map((service) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                                      borderRadius: BorderRadius.circular(16.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 22.r,
                                          backgroundColor: color.withOpacity(0.15),
                                          child: Text(
                                            service.lender.lenderName[0],
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: color),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      service.lender.lenderName,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: AppTextStyles.promoButtonText(context),
                                                    ),
                                                  ),
                                                  buildLenderCardMenu(
                                                    context: context,
                                                    service: service,
                                                    onPhone: (ctx, phone) async {
                                                      final uri = Uri.parse('tel:$phone');
                                                      if (await canLaunchUrl(uri)) {
                                                        await launchUrl(uri);
                                                      }
                                                    },
                                                    onEmail: (ctx, email) async {
                                                      final uri = Uri.parse('mailto:$email');
                                                      if (await canLaunchUrl(uri)) {
                                                        await launchUrl(uri);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 6.h),
                                              Row(
                                                children: [
                                                  Icon(Icons.email, size: 14.sp, color: Colors.grey),
                                                  SizedBox(width: 4.w),
                                                  Expanded(
                                                    child: Text(
                                                      service.lender.lenderEmail,
                                                      style: AppTextStyles.promoBody(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4.h),
                                              Row(
                                                children: [
                                                  Icon(Icons.phone, size: 15.sp, color: Colors.grey),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    service.lender.lenderPhone,
                                                    style: TextStyle(fontSize: 13.sp, color: const Color(0xFF686868)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
