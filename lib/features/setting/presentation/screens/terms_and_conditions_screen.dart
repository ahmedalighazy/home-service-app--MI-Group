import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: context.tr(LocaleKeys.legalTermsAndConditions)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            verticalSpace(16),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsAcceptance),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsServices),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsBookings),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsCancellation),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsResponsibility),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsCompanyResp),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsAccounts),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.legalTermsModifications),
              content: context.tr(LocaleKeys.legalTermsIntroduction),
            ),
          ],
        ),
      ),
    );
  }
}
