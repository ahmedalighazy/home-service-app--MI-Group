import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: AppStrings.privacyPolicyLabel),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.dividerGrey),
              ),
              child: Text(
                AppStrings.privacyPolicyIntro,
                style: AppText.regularIbm(color: AppColors.primaryText, fontSize: 14).copyWith(height: 1.6),
              ),
            ),
            SizedBox(height: 16.h),
            _buildPolicyItem(AppStrings.collectedData),
            _buildPolicyItem(AppStrings.dataUsage),
            _buildPolicyItem(AppStrings.dataProtection),
            _buildPolicyItem(AppStrings.dataSharing),
            _buildPolicyItem(AppStrings.policyModifications),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyItem(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.dividerGrey),
      ),
      child: ListTile(
        title: Text(
          title,
          style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
        ),
        trailing: const Icon(Icons.chevron_left, color: AppColors.greenPrimary),
        onTap: () {
          // TODO: Open detail for this policy part
        },
      ),
    );
  }
}
