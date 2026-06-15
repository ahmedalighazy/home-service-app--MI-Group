import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_category_item.dart';

import '../../../data/models/service_page_model.dart';


class ServiceCategoryTabBar extends StatelessWidget {
  final List<ServicePageCategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const ServiceCategoryTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.115,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // reverse=true keeps ordering right-to-left for Arabic
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        itemCount: categories.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: size.width * 0.025),
        itemBuilder: (context, index) => ServiceCategoryItem(
          category: categories[index],
          isSelected: index == selectedIndex,
          onTap: () => onCategorySelected(index),
        ),
      ),
    );
  }
}

