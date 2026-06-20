import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_expansion_tile.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: context.l10n.faq),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CustomExpansionTile(
              title: context.l10n.faqQ1,
              content: context.l10n.faqIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.faqModifyBooking,
              content: context.l10n.faqIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.faqPaymentMethods,
              content: context.l10n.faqIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.faqQ4,
              content: context.l10n.faqIntro,
            ),
            CustomExpansionTile(
              title: context.l10n.faqProblemDuringService,
              content: context.l10n.faqIntro,
            ),
          ],
        ),
      ),
    );
  }
}
