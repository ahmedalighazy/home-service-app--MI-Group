import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusM.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(),
                Row(
                  children: [
                    Text(
                      subscription.title,
                      style: AppText.ibmHeading14(color: AppColors.black),
                    ),
                    horizontalSpace(8),
                    Icon(Iconsax.calendar_tick, size: 20.r, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
          
          // Details Section
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                _buildDetailRow(
                  AppStrings.subscriptionTypeLabel,
                  subscription.type,
                  Iconsax.refresh,
                ),
                if (subscription.nextVisitDate != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    AppStrings.nextVisitLabel,
                    subscription.nextVisitDate!,
                    Iconsax.calendar_1,
                  ),
                ],
                if (subscription.nextVisitTime != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    AppStrings.timeLabel,
                    subscription.nextVisitTime!,
                    Iconsax.clock,
                  ),
                ],
                if (subscription.expiryDate != null) ...[
                  verticalSpace(12),
                  _buildDetailRow(
                    AppStrings.expiryDateLabelTitle,
                    subscription.expiryDate!,
                    Iconsax.calendar_1,
                  ),
                ],
                verticalSpace(12),
                _buildPriceRow(),
                verticalSpace(16),
                CustomButtom(
                  onTap: onTap,
                  text: subscription.status == SubscriptionStatus.active 
                    ? AppStrings.manageSubscription 
                    : (subscription.status == SubscriptionStatus.paused ? AppStrings.reactivateBtn : AppStrings.subscribeAgainBtn),
                  textStyle: AppText.ibmButton16(color: AppColors.white),
                  startColor: subscription.status == SubscriptionStatus.paused ? AppColors.yellow : AppColors.primary,
                  endColor: subscription.status == SubscriptionStatus.paused ? AppColors.yellow : AppColors.dark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    String label;

    switch (subscription.status) {
      case SubscriptionStatus.active:
        bgColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        label = AppStrings.activeStatus;
        break;
      case SubscriptionStatus.paused:
        bgColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFD97706);
        label = AppStrings.pausedStatus;
        break;
      case SubscriptionStatus.ended:
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFDC2626);
        label = AppStrings.endedStatus;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusCircular.r),
      ),
      child: Text(
        label,
        style: AppText.ibmDescription12(color: textColor).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: AppText.ibmDescription14(color: AppColors.primaryText).copyWith(fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Text(
              label,
              style: AppText.ibmDescription14(color: AppColors.textLightGrey),
            ),
            horizontalSpace(8),
            Icon(icon, size: 18.r, color: AppColors.textLightGrey),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${subscription.price.toInt()} ${AppStrings.monthlyPriceSuffix}',
          style: AppText.ibmHeading14(color: AppColors.primary),
        ),
        Row(
          children: [
            Text(
              AppStrings.priceLabel,
              style: AppText.ibmDescription14(color: AppColors.textLightGrey),
            ),
            horizontalSpace(8),
            Icon(Iconsax.money_2, size: 18.r, color: AppColors.textLightGrey),
          ],
        ),
      ],
    );
  }
}
