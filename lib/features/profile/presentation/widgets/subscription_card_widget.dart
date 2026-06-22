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

          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFE8FBFF),
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
                      subscription.title ?? '',
                      style: AppText.ibmHeading14(color: AppColors.black),
                    ),
                  ],
                ),
                _buildStatusBadge(context),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                _buildDetailRow(
                  AppStrings.subscriptionTypeLabel,
                  subscription.type ?? '',
                  IconsPath.loadingDark,
                ),
                if (subscription.nextVisitDate != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    AppStrings.nextVisitLabel,
                    subscription.nextVisitDate?.toIso8601String().split('T')[0] ?? '',
                    IconsPath.calenderBlack,
                  ),
                ],
                if (subscription.nextVisitTime != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    AppStrings.timeLabel,
                    subscription.nextVisitTime ?? '',
                    IconsPath.time,
                  ),
                ],
                if (subscription.expiryDate != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    AppStrings.expiryDateLabelTitle,
                    subscription.expiryDate?.toIso8601String().split('T')[0] ?? '',
                    IconsPath.group,
                  ),
                ],
                verticalSpace(12),
                _buildPriceRow(context),
                verticalSpace(16),
                CustomButtom(
                  onTap: onTap,
                  text: subscription.status == 'active'
                      ? AppStrings.manageSubscription
                      : (subscription.status == 'paused'
                            ? AppStrings.reactivateBtn
                            : AppStrings.subscribeAgainBtn),
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

  Widget _buildStatusBadge() {
    Color bgColor = const Color(0xFFECFDF5);
    Color textColor = const Color(0xFF059669);
    String label = AppStrings.activeStatus;

    switch (subscription.status) {
      case 'active':
        bgColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        label = AppStrings.activeStatus;
        break;
      case 'paused':
        bgColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFD97706);
        label = AppStrings.pausedStatus;
        break;
      case 'ended':
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFDC2626);
        label = AppStrings.endedStatus;
        break;
      default:
        bgColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        label = AppStrings.activeStatus;
    }

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
          '${subscription.price?.toInt() ?? 0} ${AppStrings.monthlyPriceSuffix}',
          style: AppText.ibmHeading14(color: AppColors.primary),
        ),
      ],
    );
  }
}
