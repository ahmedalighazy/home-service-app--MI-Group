import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/app_strings.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/features/home/presentation/widgets/section_header.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_card.dart';

class HomePopularServicesSection extends StatelessWidget {
  const HomePopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Column(
        children: [
          const SectionHeader(title: AppStrings.mostPopular),

          const SizedBox(height: AppSizes.spacingMedium),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              children: [
                ServiceCard(
                  title: AppStrings.deepFurnitureCleaning,
                  imagePath: AppAssets.deepFurnitureCleaning,
                  discount: AppStrings.discountUpTo70,

                  onTap: () {},
                ),

                const SizedBox(width: AppSizes.spacingMedium),

                ServiceCard(
                  title: AppStrings.pestControlService,
                  imagePath: AppAssets.pestControlService,
                  discount: AppStrings.discountUpTo20,
                  onTap: () {},
                ),

                const SizedBox(width: AppSizes.spacingMedium),

                ServiceCard(
                  title: AppStrings.glassCleaning,
                  imagePath: AppAssets
                      .glassCleaning, // Replace with actual image for glass cleaning
                  badge: AppStrings.newService,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
