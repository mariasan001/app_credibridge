import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app_creditos/src/shared/theme/app_colors.dart';

class PromocionCardSkeleton extends StatelessWidget {
  const PromocionCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.promoShadow,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Título + financiera
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 10,
                              width: 120,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Descripción
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 12,
                    width: 200,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 16),

                  // Beneficios fake
                  for (int i = 0; i < 3; i++) ...[
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 16, color: Colors.white),
                        const SizedBox(width: 8),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ],
              ),
            ),

            // Footer
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.promoYellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
