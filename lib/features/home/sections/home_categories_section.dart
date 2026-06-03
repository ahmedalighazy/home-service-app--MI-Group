import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/app_strings.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_category_card.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceCategoryCard(
              iconPath: IconsPath.cleanerIcon,
              title: AppStrings.deepCleaning,
              //AppStrings.institutionServices,
              onTap: () {},
            ),

            const SizedBox(width: AppSizes.spacingMedium),

            ServiceCategoryCard(
              iconPath: IconsPath.manualCleanerIcon,
              title: AppStrings.homeCleaning,
              //AppStrings.pestControl,
              onTap: () {},
            ),

            const SizedBox(width: AppSizes.spacingMedium),

            ServiceCategoryCard(
              iconPath: IconsPath.bugIcon,
              title: AppStrings.pestControl,
              onTap: () {},
            ),

            const SizedBox(width: AppSizes.spacingMedium),

            ServiceCategoryCard(
              iconPath: IconsPath.institutionsIcon,
              title: AppStrings.institutionServices,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
