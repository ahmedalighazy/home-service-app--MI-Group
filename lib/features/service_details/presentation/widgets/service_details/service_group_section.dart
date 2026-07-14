import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_group_header.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_item_card.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../data/models/service_page_model.dart';

class ServiceGroupSection extends StatelessWidget {
  final ServicePageGroupModel group;

  const ServiceGroupSection({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ServiceGroupHeader(title: group.categoryTitle),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          ...group.items.indexed.map(
            (entry) => ServiceItemCard(
              key: ValueKey('${group.categoryTitle}_${entry.$1}'),
              itemKey: '${group.categoryTitle}|${entry.$1}',
              item: entry.$2,
              category: group.categoryTitle,
            ),
          ),
        ],
      ),
    );
  }
}
