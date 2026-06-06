import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.termsAndConditionsLabel),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const CustomExpansionTile(
              title: AppStrings.data,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.services,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.bookings,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.serviceCancellation,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.responsibility,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.companyResponsibilities,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.accounts,
              content: AppStrings.termsIntro,
            ),
            const CustomExpansionTile(
              title: AppStrings.modifications,
              content: AppStrings.termsIntro,
            ),
          ],
        ),
      ),
    );
  }
}
