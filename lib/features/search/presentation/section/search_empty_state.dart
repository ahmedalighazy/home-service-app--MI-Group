import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key, required this.searchInputText});
  final String searchInputText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.searchIcon),
              SizedBox(height: AppSizes.spacingLarge),

              Text(
                context.l10n.noResultsFound,
                style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.primaryText,
                ),
              ),

              SizedBox(height: AppSizes.spacingSmall),

              Text(
                context.l10n.noResultsFoundDescription,
                textAlign: TextAlign.center,
                style: AppText.ibmDescription14(color: AppColors.placeholder),
              ),
              Text(
                searchInputText,
                textAlign: TextAlign.center,
                style: AppText.ibmDescription14(color: AppColors.placeholder),
              ),

              SizedBox(height: AppSizes.spacing),

              CustomButtom(
                text: context.l10n.browseServices,
                onTap: () {},
                textStyle: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.white,
                ),
                startColor: AppColors.greenPrimary,
                endColor: AppColors.dark,
              ),

              SizedBox(height: AppSizes.spacingMedium),

              CustomButtom(
                text: context.l10n.tryOtherWords,
                onTap: () {},
                textStyle: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.gray,
                ),
                startColor: AppColors.white,
                endColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
