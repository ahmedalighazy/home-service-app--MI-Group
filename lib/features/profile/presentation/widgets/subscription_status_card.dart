import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/features/profile/data/models/subscription_model.dart';

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
          const _ActiveStatusBadge(),
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
      decoration: ShapeDecoration(
        color: const Color(0xFFECFDF5) ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Text(
        context.tr(LocaleKeys.profileSubscriptionStatusActive),
        style: AppText.ibmDescription12(
          color: const Color(0xFF059669),
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
