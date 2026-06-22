import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.privacyPolicyLabel),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CustomExpansionTile(
              title: context.tr(LocaleKeys.profileStart),
              content: context.tr(LocaleKeys.legalPrivacyIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalCollectedData),
              content: context.tr(LocaleKeys.legalPrivacyIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalDataUsage),
              content: context.tr(LocaleKeys.legalPrivacyIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalDataProtection),
              content: context.tr(LocaleKeys.legalPrivacyIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalDataSharing),
              content: context.tr(LocaleKeys.legalPrivacyIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalPolicyModifications),
              content: context.tr(LocaleKeys.legalPrivacyIntroduction),
            ),
          ],
        ),
      ),
    );
  }
}
