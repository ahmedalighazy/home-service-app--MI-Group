import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/search/domain/entities/search_suggestion_entity.dart';

class SearchSuggestionCard extends StatelessWidget {
  const SearchSuggestionCard({super.key, required this.suggestion, this.onTap});

  final SearchSuggestionEntity suggestion;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              child: Image.asset(
                suggestion.imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: AppSizes.spacingMedium),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.title,
                    textAlign: TextAlign.right,
                    style: AppText.ibmPlaceholder14(
                      color: AppColors.primaryText,
                    ),
                  ),

                  SizedBox(height: AppSizes.spacingMin),

                  Text(
                    suggestion.description,
                    textAlign: TextAlign.right,
                    style: AppText.ibmCaption11(color: AppColors.body),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
