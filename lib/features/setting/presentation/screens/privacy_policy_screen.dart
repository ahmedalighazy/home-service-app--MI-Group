import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: context.l10n.privacyPolicyLabel),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CustomExpansionTile(
              title: context.l10n.advancePaymentLabel,
              content: context.l10n.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.collectedData,
              content: context.l10n.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.dataUsage,
              content: context.l10n.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.dataProtection,
              content: context.l10n.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.dataSharing,
              content: context.l10n.privacyPolicyIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.policyModifications,
              content: context.l10n.privacyPolicyIntro,
            ),
          ],
        ),
      ),
    );
  }
}
