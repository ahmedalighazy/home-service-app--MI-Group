import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/search/presentation/widgets/custom_button.dart';

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
                AppStrings.noResultsFound,
                style: AppText.ibmPlexSansArabic16SemiBold.copyWith(
                  color: AppColors.primaryText,
                ),
              ),

              SizedBox(height: AppSizes.spacingSmall),

              Text(
                AppStrings.noResultsFoundDescription,
                textAlign: TextAlign.center,
                style: AppText.ibmDescription14(color: AppColors.placeholder),
              ),
              Text(
                searchInputText,
                textAlign: TextAlign.center,
                style: AppText.ibmDescription14(color: AppColors.placeholder),
              ),

              SizedBox(height: AppSizes.spacing),

              CustomButton(
                text: AppStrings.browseServices,
                textColor: AppColors.white,
                backGroundColor: [AppColors.greenPrimary, AppColors.dark],
              ),

              SizedBox(height: AppSizes.spacingMedium),

              CustomButton(
                text: AppStrings.tryOtherWords,
                textColor: AppColors.gray,
                backGroundColor: [AppColors.white],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
