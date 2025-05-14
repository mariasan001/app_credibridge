import 'package:app_creditos/src/features/directorio/widget/lender_card_menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_creditos/src/features/auth/models/user_model.dart';
import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_skeleton.dart';
import 'package:app_creditos/src/shared/components/ustom_app_bar.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_utils.dart';
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
    try {
      final data = await DirectorioService.obtenerServiciosActivos();
      setState(() {
        _allGrouped = data;
        _filteredGrouped = data;
      });
      return data;
    } catch (e) {
      print('Error cargando servicios: $e');
      rethrow;
    }
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
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F2),
      appBar: CustomAppBar(user: widget.user),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Directorio', style: AppTextStyles.titleheader(context)),
                          Text(
                            'Consulta servicios disponibles',
                            style: AppTextStyles.promoListText(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar servicio o institución',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: AppTextStyles.inputHint(context),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<LenderServiceGrouped>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 6,
                      itemBuilder: (_, __) => const LenderCardSkeleton(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Ocurrió un error al cargar el directorio',
                        style: AppTextStyles.linkMuted(context)!
                            .copyWith(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || _filteredGrouped.isEmpty) {
                    return Center(
                      child: Text('No se encontraron resultados.',
                          style: AppTextStyles.linkMuted(context)),
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
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              group.serviceTypeDesc.toUpperCase(),
                              style: AppTextStyles.linkBold(context).copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...group.services.map(
                            (service) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
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
                                    radius: 22,
                                    // ignore: deprecated_member_use
                                    backgroundColor: color.withOpacity(0.15),
                                    child: Text(
                                      service.lender.lenderName[0],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                service.lender.lenderName,
                                                style:
                                                    AppTextStyles.promoButtonText(context),
                                              ),
                                            ),
                                            buildLenderCardMenu(
                                              context: context,
                                              service: service,
                                              onPhone: (ctx, phone) async {
                                                final Uri telUri =
                                                    Uri.parse('tel:$phone');
                                                if (await canLaunchUrl(telUri)) {
                                                  await launchUrl(telUri);
                                                }
                                              },
                                              onEmail: (ctx, email) async {
                                                final Uri emailUri =
                                                    Uri(scheme: 'mailto', path: email);
                                                if (await canLaunchUrl(emailUri)) {
                                                  await launchUrl(emailUri);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(Icons.email,
                                                size: 14, color: Color.fromARGB(255, 158, 158, 158)),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                service.lender.lenderEmail ??
                                                    'correo@desconocido.com',
                                                style:
                                                    AppTextStyles.promoBody(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone,
                                                size: 14, color: Color.fromARGB(255, 117, 117, 117)),
                                            const SizedBox(width: 4),
                                            Text(
                                              service.lender.lenderPhone,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color.fromARGB(255, 104, 104, 104),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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