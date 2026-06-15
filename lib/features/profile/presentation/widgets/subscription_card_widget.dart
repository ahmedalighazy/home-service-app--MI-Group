import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final SubscriptionModel subscription;
  final VoidCallback onTap;

  const SubscriptionCardWidget({
    super.key,
    required this.subscription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFE8FBFF), // Light cyan from YAML
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusM.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(IconsPath.clean),
                    horizontalSpace(8),

                    Text(
                      context.tr(subscription.title),
                      style: AppText.ibmHeading14(color: AppColors.black),
                    ),
                  ],
                ),
                _buildStatusBadge(context),
              ],
            ),
          ),

          // Details Section
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                _buildDetailRow(
                  context.tr(LocaleKeys.profileSubscriptionTypeLabel),
                  context.tr(subscription.type),
                  IconsPath.loadingDark,
                ),
                if (subscription.nextVisitDate != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    context.tr(LocaleKeys.profileNextVisitLabel),
                    subscription.nextVisitDate!,
                    IconsPath.calenderBlack,
                  ),
                ],
                if (subscription.nextVisitTime != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    context.tr(LocaleKeys.profileTimeLabel),
                    subscription.nextVisitTime!,
                    IconsPath.time,
                  ),
                ],
                if (subscription.expiryDate != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    context.tr(LocaleKeys.profileExpiryDateLabel),
                    subscription.expiryDate!,
                    IconsPath.group,
                  ),
                ],
                verticalSpace(12),
                _buildPriceRow(context),
                verticalSpace(16),
                CustomButtom(
                  onTap: onTap,
                  text: subscription.status == SubscriptionStatus.active
                      ? context.tr(LocaleKeys.profileManageSubscription)
                      : (subscription.status == SubscriptionStatus.paused
                            ? context.tr(LocaleKeys.profileReactivateBtn)
                            : context.tr(LocaleKeys.profileSubscribeAgainBtn)),
                  textStyle: AppText.ibmButton16(color: AppColors.white),
                  startColor: AppColors.primary,
                  endColor: AppColors.dark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final (Color bgColor, Color textColor, String key) = switch (subscription.status) {
      SubscriptionStatus.active => (
        const Color(0xFFECFDF5),
        const Color(0xFF059669),
        LocaleKeys.profileSubscriptionStatusActive,
      ),
      SubscriptionStatus.paused => (
        const Color(0xFFFFFBEB),
        const Color(0xFFD97706),
        LocaleKeys.profileSubscriptionStatusPaused,
      ),
      SubscriptionStatus.ended => (
        const Color(0xFFFEF2F2),
        const Color(0xFFDC2626),
        LocaleKeys.profileSubscriptionStatusEnded,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusCircular.r),
      ),
      child: Text(
        context.tr(key),
        style: AppText.ibmDescription12(
          color: textColor,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, String icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon),
            horizontalSpace(8),

            Text(
              label,
              style: AppText.ibmDescription14(color: AppColors.textLightGrey),
            ),
            // Icon(icon, size: 18.r, color: AppColors.textLightGrey),
          ],
        ),
        Text(
          value,
          style: AppText.ibmDescription14(
            color: AppColors.primaryText,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(IconsPath.group),

            horizontalSpace(8),

            Text(
              context.tr(LocaleKeys.profilePriceLabel),
              style: AppText.ibmDescription14(color: AppColors.textLightGrey),
            ),
          ],
        ),
        Text(
          '${subscription.price.toInt()} ${context.tr(LocaleKeys.profileMonthlyPriceSuffix)}',
          style: AppText.ibmHeading14(color: AppColors.primary),
        ),
      ],
    );
  }
}
