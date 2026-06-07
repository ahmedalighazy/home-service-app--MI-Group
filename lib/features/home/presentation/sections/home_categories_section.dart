import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_category_card.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    void navigateToCategory(int index) {
      switch (index) {
        case 0:
          context.push(AppRouter.serviceDetailsScreen);
          break;
        case 1:
          context.push(AppRouter.workerFilter);
          break;
        case 3:
          context.push(AppRouter.corporateServices);
          break;
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.paddingXLargeHeight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories
              .asMap()
              .entries
              .map(
                (entry) => ServiceCategoryCard(
                  iconPath: entry.value.iconPath,
                  title: entry.value.title,
                  onTap: () => navigateToCategory(entry.key),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
