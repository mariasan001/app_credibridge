import 'package:flutter/material.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class SinPromocionesWidget extends StatelessWidget {
  final VoidCallback? onAccionNueva;

  const SinPromocionesWidget({super.key, this.onAccionNueva});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 156, 156, 156),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🛍️',
              style: TextStyle(fontSize: 48),
            ),

            const SizedBox(height: 20),

            Text(
              'No hay promociones activas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
             color: AppColors.text(context),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Vuelve pronto para descubrir nuevas oportunidades exclusivas.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),

            if (onAccionNueva != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onAccionNueva,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Volver a intentar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.text(context),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
