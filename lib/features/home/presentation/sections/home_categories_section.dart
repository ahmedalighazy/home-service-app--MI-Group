import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_category_card.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.padding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories
              .map(
                (category) => Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: AppSizes.spacingMedium,
                  ),
                  child: ServiceCategoryCard(
                    iconPath: category.iconPath,
                    title: category.title,
                    onTap: () {},
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
