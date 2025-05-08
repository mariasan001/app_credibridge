import 'package:flutter/material.dart';

Widget buildPromocionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('¡Protege tu auto y ahorra! 🚗', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'En COORDINADOR NACIONAL DE SEGUROS, aprovecha esta oportunidad con tranquilidad. '
            'Por tiempo limitado, obtén 10% de descuento en tu seguro de auto.',
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('✅ Seguro amplio y económico'),
              Text('✅ Atención personalizada'),
              Text('✅ Sin deducible por pérdida total'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Expira el 26 de junio del 2025', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Chip(label: Text('Lo quiero ❤️'), backgroundColor: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

