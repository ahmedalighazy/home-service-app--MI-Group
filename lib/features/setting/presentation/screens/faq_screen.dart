import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
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
              title: AppStrings.faqQ1,
              content: AppStrings.faqIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.faqQ2,
              content: AppStrings.faqIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.faqQ3,
              content: AppStrings.faqIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.faqQ4,
              content: AppStrings.faqIntro,
            ),
            CustomExpansionTile(
              title: AppStrings.faqQ5,
              content: AppStrings.faqIntro,
            ),
          ],
        ),
      ),
    );
  }
}
