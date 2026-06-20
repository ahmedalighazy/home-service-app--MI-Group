import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class PopularSearchesSection extends StatelessWidget {
  const PopularSearchesSection({super.key, required this.searches});

  final List<String> searches;

  @override
  Widget build(BuildContext context) {
    if (searches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: AppSizes.paddinMinWidth),
          child: Text(
            context.l10n.popularServices,
            style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
              color: AppColors.primaryText,
            ),
          ),
        ),

        SizedBox(height: AppSizes.spacingMedium),

        Wrap(
          alignment: WrapAlignment.start,
          spacing: AppSizes.spacingSmall,
          runSpacing: AppSizes.spacingSmall,
          children: searches.map((search) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall,
                vertical: AppSizes.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
                border: Border.all(color: AppColors.borderInputs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconsPath.trendingUp,
                    width: 12,
                    height: 12,
                    colorFilter: ColorFilter.mode(
                      AppColors.iconDisabled,
                      BlendMode.srcIn,
                    ),
                  ),

                  SizedBox(width: AppSizes.spacingSmallWidth),

                  Text(
                    search,
                    style: AppText.ibmFieldLabel12(
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
