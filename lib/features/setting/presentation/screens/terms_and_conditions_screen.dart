import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: context.l10n.termsAndConditionsLabel),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CustomExpansionTile(
              title: context.l10n.acceptanceOfTerms,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.services,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.bookings,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.serviceCancellation,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.responsibility,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.companyResponsibilities,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.accounts,
              content: context.l10n.termsIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.modifications,
              content: context.l10n.termsIntro,
            ),
          ],
        ),
      ),
    );
  }
}
