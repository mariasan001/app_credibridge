import 'package:flutter/material.dart';

class DescuentoCardSkeleton extends StatelessWidget {
  const DescuentoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 16,
            width: 180,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Container(
            height: 48,
            width: 120,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          Container(
            height: 14,
            width: 240,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              return Container(
                width: 80,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}