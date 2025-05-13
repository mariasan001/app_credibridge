import 'package:app_creditos/src/features/inicio/model/Crea%20tu%20archivo%20model_promociones.dart';
import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/inicio/service/promociones_service.dart';

class PromocionesActivasWidget extends StatelessWidget {
  const PromocionesActivasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Promotion>>(
      future: PromotionService.obtenerPromocionesActivas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final promociones = snapshot.data ?? [];

        if (promociones.isEmpty) {
          return const Center(child: Text('No hay promociones activas.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: promociones.length,
          itemBuilder: (context, index) {
            final promo = promociones[index];
            return ListTile(
              leading: const Icon(Icons.local_offer),
              title: Text(promo.promotionTitle),
              subtitle: Text(
                'Financiera: ${promo.lenderName}\n'
                'Servicio: ${promo.serviceTypeDesc}\n'
                'Beneficios: ${promo.benefits.join(', ')}',
              ),
            );
          },
        );
      },
    );
  }
}
