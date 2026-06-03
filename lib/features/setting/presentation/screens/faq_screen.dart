import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.faq),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildFAQItem(AppStrings.faqQ1),
            _buildFAQItem(AppStrings.faqQ2),
            _buildFAQItem(AppStrings.faqQ3),
            _buildFAQItem(AppStrings.faqQ4),
            _buildFAQItem(AppStrings.faqQ5),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.dividerGrey),
      ),
      child: ListTile(
        title: Text(
          question,
          style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
        ),
        trailing: const Icon(Icons.chevron_left, color: AppColors.greenPrimary),
        onTap: () {
          // TODO: Open FAQ answer
        },
      ),
    );
  }
}
