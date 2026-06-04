import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SubscriptionStatusCard extends StatelessWidget {
  final SubscriptionModel subscription;

  const SubscriptionStatusCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFE8FBFF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _ActiveStatusBadge(),
          Row(
            children: [
              Text(
                subscription.title,
                style: AppText.ibmHeading14(color: AppColors.black),
              ),
              horizontalSpace(8),
              Icon(Iconsax.calendar_tick, size: 24.r, color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveStatusBadge extends StatelessWidget {
  const _ActiveStatusBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(44.r),
      ),
      child: Text(
        AppStrings.activeStatus,
        style: AppText.ibmDescription12(color: const Color(0xFF059669))
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
