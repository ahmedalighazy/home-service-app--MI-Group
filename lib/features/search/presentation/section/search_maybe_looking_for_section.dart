import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/search/domain/entities/search_suggestion_entity.dart';
import 'package:home_service_app/features/search/presentation/widgets/search_suggestion_card.dart';

class SearchMaybeLookingForSection extends StatelessWidget {
  const SearchMaybeLookingForSection({super.key, required this.items});

  final List<SearchSuggestionEntity> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.youMightBeLookingFor,
            style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
              color: AppColors.primaryText,
            ),
          ),

          SizedBox(height: AppSizes.spacingMedium),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) =>
                SizedBox(height: AppSizes.spacingMedium),
            itemBuilder: (context, index) {
              final item = items[index];

              return SearchSuggestionCard(suggestion: item);
            },
          ),
        ],
      ),
    );
  }
}
