import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FormularioSimulacionSkeleton extends StatelessWidget {
  const FormularioSimulacionSkeleton({super.key});

  Widget _shimmerBox({double height = 48, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2A2A2A)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(height: 14, width: 180), // Título selector
          const SizedBox(height: 8),
          _shimmerBox(height: isTablet ? 56 : 48), // Selector tipo

          const SizedBox(height: 20),
          _shimmerBox(height: 14, width: 200), // Título monto
          const SizedBox(height: 8),
          _shimmerBox(), // Input monto

          const SizedBox(height: 20),
          _shimmerBox(height: 14, width: 160), // Título plazos
          const SizedBox(height: 8),
          _shimmerBox(), // Input plazos

          const SizedBox(height: 24),
          _shimmerBox(height: 48), // Botón simular
        ],
      ),
    );
  }
}
