import 'package:app_creditos/src/features/directorio/services/directorio_service.dart';
import 'package:app_creditos/src/features/directorio/model/lender_service_model.dart';
import 'package:app_creditos/src/features/directorio/utils/alphabetical_group_builder.dart';
import 'package:app_creditos/src/features/directorio/utils/lender_card.dart';
import 'package:app_creditos/src/features/directorio/widget/directorio_utils.dart';
import 'package:app_creditos/src/features/directorio/widget/lender_card_skeleton.dart';
import 'package:flutter/material.dart';

class DirectorioPage extends StatefulWidget {
  const DirectorioPage({super.key});

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
      _filteredGrouped = _allGrouped.map((group) {
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
      }).where((group) => group.services.isNotEmpty).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F2),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Directorio', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                  CircleAvatar(radius: 16, backgroundColor: Colors.black, child: Text('M', style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ingresa servicio o institución',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            const SizedBox(height: 12),
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
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              group.serviceTypeDesc,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                            ),
                          ),
                         ...buildAlphabeticalGroups(group: group)

                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}