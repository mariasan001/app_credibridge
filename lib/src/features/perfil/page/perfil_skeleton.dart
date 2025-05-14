import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PerfilSkeleton extends StatelessWidget {
  const PerfilSkeleton({super.key});

  Widget buildShimmerBox({double height = 16, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget buildShimmerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildShimmerBox(height: 12, width: 100),
                buildShimmerBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildShimmerSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildShimmerBox(height: 18, width: 120),
          const SizedBox(height: 16),
          ...List.generate(4, (_) => buildShimmerField()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(4, (_) => buildShimmerSection()),
        ),
      ),
    );
  }
}
