import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/home/domain/entities/category_entity.dart';
import 'package:home_service_app/features/home/presentation/widgets/service_category_card.dart';

class SearchCategoriesSection extends StatelessWidget {
  const SearchCategoriesSection({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr(LocaleKeys.categories),
            style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
              color: AppColors.primaryText,
            ),
          ),

          SizedBox(height: AppSizes.spacingMedium),

          SizedBox(
            height: AppSizes.searchCategoriesIconHight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: AppSizes.spacingMedium,
                  ),
                  child: ServiceCategoryCard(
                    iconPath: category.iconUrl,
                    title: category.name,
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
