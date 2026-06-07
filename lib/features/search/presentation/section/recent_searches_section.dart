import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/themes/text/app_text.dart';
import '../widgets/recent_search_item.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const recentSearches = ['تنظيف منزل', 'مكافحة آفات', 'تعقيم'];

    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                AppStrings.recentSearches,
                style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
              const Spacer(),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.borderFocus,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.clearAll,
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
