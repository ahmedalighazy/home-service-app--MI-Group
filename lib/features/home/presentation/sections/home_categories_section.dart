import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_category_card.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.paddingXLargeHeight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories
              .map(
                (category) => ServiceCategoryCard(
                  iconPath: category.iconPath,
                  title: category.title,
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
