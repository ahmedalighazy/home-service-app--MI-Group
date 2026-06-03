import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String? badge;
  final String? discount;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.badge,
    this.discount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Image Section
            Container(
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radius),
                  topRight: Radius.circular(AppSizes.radius),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.radius),
                      topRight: Radius.circular(AppSizes.radius),
                    ),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Discount Badge
                  if (discount != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E275C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          discount!,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),

                  // New Badge
                  if (badge != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E275C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          badge!,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),

                  // Arrow Button
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Iconsax.arrow_left_3_copy,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Title Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
