import 'package:animations/animations.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/utils/alphabetical_group_builder.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_utils.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_skeleton.dart';
import 'package:app_creditos/src/features/inicio/page/dashboard_page.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
    setState(() {
      _allGrouped = data;
      _filteredGrouped = data;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Credi',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
              const TextSpan(
                text: 'Bring',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Notificaciones
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F0EA), // fondo claro tipo beige
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 25,
            ),
          ),

          // Ícono de opciones tipo "grid"
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.grid_view_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      OpenContainer(
                        
                        transitionType: ContainerTransitionType.fadeThrough,
                        transitionDuration: const Duration(milliseconds: 400),
                        closedElevation: 0,
                        closedColor: Colors.transparent,
                        closedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        openBuilder:
                            (context, _) =>
                                HomePage(user: widget.user,),
                        closedBuilder:
                            (context, openContainer) =>
                                const Icon(Icons.arrow_back, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Directorio',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Ingresa servicio o institución',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: FutureBuilder<List<LenderServiceGrouped>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 6,
                      itemBuilder: (_, __) => const LenderCardSkeleton(),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filteredGrouped.length,
                    itemBuilder: (context, index) {
                      final group = _filteredGrouped[index];
                      final color = getColorForService(group.serviceTypeDesc);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 8,
                              left: 10,
                            ),
                            child: Text(
                              group.serviceTypeDesc,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ),
                          ...buildAlphabeticalGroups(group: group),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
