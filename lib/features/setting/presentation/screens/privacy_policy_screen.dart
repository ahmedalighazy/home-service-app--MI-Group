import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.privacyPolicyLabel),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: const Column(
          children: [
            CustomExpansionTile(
              title: AppStrings.start,
              content: AppStrings.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.collectedData,
              content: AppStrings.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.dataUsage,
              content: AppStrings.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.dataProtection,
              content: AppStrings.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.dataSharing,
              content: AppStrings.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.policyModifications,
              content: AppStrings.privacyPolicyIntro,
            ),
          ],
        ),
      ),
    );
  }
}
