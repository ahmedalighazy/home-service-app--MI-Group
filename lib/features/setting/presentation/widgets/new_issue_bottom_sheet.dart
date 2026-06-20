import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';

import '../../../../core/widgets/custom_buttom.dart';

class NewIssueBottomSheet extends StatelessWidget {
  const NewIssueBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.dividerGrey,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          verticalSpace(20),
          Text(
            context.l10n.newIssueTitle,
            style: AppText.boldIbm(color: AppColors.primaryText, fontSize: 18),
          ),
          verticalSpace(24),
          _buildFieldLabel(context.l10n.issueTitleLabel),
          verticalSpace(8),
          _buildTextField(context.l10n.issueTitleHint),
          verticalSpace(16),
          _buildFieldLabel(context.l10n.orderNumberLabel),
          verticalSpace(8),
          _buildTextField(context.l10n.issueTitleHint),
          verticalSpace(16),
          _buildFieldLabel(context.l10n.issueDescLabel),
          verticalSpace(8),
          _buildTextField(context.l10n.issueDescHint, maxLines: 4),
          verticalSpace(24),
          SizedBox(
            width: double.infinity,
            child: CustomButtom(
              text: context.l10n.send,
              onTap: () => context.pop(),
              startColor: AppColors.greenPrimary,
              endColor: AppColors.dark,
              textStyle: AppText.ibmButton16(color: AppColors.white),
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppText.mediumIbm(color: AppColors.primaryText, fontSize: 14),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppText.regularIbm(
          color: AppColors.textLightGrey,
          fontSize: 14,
        ),
        fillColor: AppColors.inputBg,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }
}
