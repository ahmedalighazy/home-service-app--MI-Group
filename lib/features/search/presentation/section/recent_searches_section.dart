import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/search/presentation/widgets/recent_search_item.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({
    super.key,
    required this.recentSearches,
    this.onClearAll,
  });

  final List<String> recentSearches;
  final VoidCallback? onClearAll;

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.tr(LocaleKeys.recentSearches),
                style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.primaryText,
                ),
              ),

              const Spacer(),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.borderFocus,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
                ),
                child: TextButton(
                  onPressed: onClearAll,
                  child: Text(
                    context.tr(LocaleKeys.clearAll),
                    style: AppText.ibmFieldLabel12(color: AppColors.bgPrimary),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.spacingSmall),

          ...recentSearches.map((search) => RecentSearchItem(title: search)),
        ],
      ),
    );
  }
}
