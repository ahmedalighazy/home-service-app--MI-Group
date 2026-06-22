import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.faq),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CustomExpansionTile(
              title: context.tr(LocaleKeys.faqQ1),
              content: context.tr(LocaleKeys.faqIntro),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.faqQ2),
              content: context.tr(LocaleKeys.faqIntro),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.faqQ3),
              content: context.tr(LocaleKeys.faqIntro),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.faqQ4),
              content: context.tr(LocaleKeys.faqIntro),
            ),
            CustomExpansionTile(
              title: context.tr(LocaleKeys.faqQ5),
              content: context.tr(LocaleKeys.faqIntro),
            ),
          ],
        ),
      ),
    );
  }
}
