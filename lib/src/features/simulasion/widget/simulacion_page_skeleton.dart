import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SimulacionPageSkeleton extends StatelessWidget {
  const SimulacionPageSkeleton({super.key});

  Widget _shimmerBox({double height = 48, double width = double.infinity, double radius = 12}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Título y subtítulo
          _shimmerBox(height: 24, width: 180),
          const SizedBox(height: 8),
          _shimmerBox(height: 16, width: 260),

          const SizedBox(height: 32),

          // Selector tipo simulación
          _shimmerBox(height: isTablet ? 56 : 48),
          const SizedBox(height: 24),

          // Monto deseado
          _shimmerBox(height: 16, width: 200),
          const SizedBox(height: 8),
          _shimmerBox(),

          const SizedBox(height: 24),

          // Plazo
          _shimmerBox(height: 16, width: 180),
          const SizedBox(height: 8),
          _shimmerBox(),

          const SizedBox(height: 24),

          // Botón simular
          _shimmerBox(height: 48),

          const SizedBox(height: 32),

          // Contenedor CAT
          _shimmerBox(height: 200, radius: 16),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
