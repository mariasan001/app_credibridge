import 'package:flutter/material.dart';
import 'package:app_creditos/src/features/inicio/model/model_promociones.dart';

class PromocionDetallePage extends StatelessWidget {
  final Promotion promo;

  const PromocionDetallePage({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(promo.promotionTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text('Aquí irá el detalle completo de la promoción "${promo.promotionTitle}"'),
      ),
    );
  }
}
