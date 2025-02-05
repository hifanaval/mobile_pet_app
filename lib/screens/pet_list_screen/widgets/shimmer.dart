import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/components/sized_box.dart';

class PetProfileCardShimmer extends StatelessWidget {
  const PetProfileCardShimmer({
    super.key,
    required this.size,
    required this.isDark,
  });

  final Size size;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.5,
      height: size.height / 3,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(5),
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder with custom shape
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height / 6.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // Heart icon placeholder
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Gender icon placeholder
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            kHeight(8),
            // Name placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                width: size.width / 4,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            kHeight(10),
            // Location row placeholder
            Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                kWidth(3),
                Container(
                  width: size.width / 4,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Grid shimmer for multiple cards
class PetGridShimmer extends StatelessWidget {
  const PetGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 6, // Number of shimmer items to show
      itemBuilder: (context, index) {
        return PetProfileCardShimmer(
          size: size,
          isDark: isDark,
        );
      },
    );
  }
}
