import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final VoidCallback onMoreTap;

  const PaymentCardWidget({
    super.key,
    required this.paymentMethod,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingM.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        border: Border.all(color: AppColors.borderGrey),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.inputBg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              paymentMethod.iconPath,
              width: 32.w,
              height: 20.h,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${paymentMethod.brand} •••• ${paymentMethod.lastFourDigits}',
                      style: AppText.ibmHeading16(color: AppColors.primaryText),
                    ),
                    if (paymentMethod.isDefault) ...[
                      horizontalSpace(8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBlue,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'افتراضي',
                          style: AppText.ibmDescription10(color: AppColors.white),
                        ),
                      ),
                    ],
                  ],
                ),
                verticalSpace(4),
                Text(
                  'ينتهي في ${paymentMethod.expiryDate}',
                  style: AppText.ibmDescription12(color: AppColors.textLightGrey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onMoreTap,
            icon: SvgPicture.asset(
              IconsPath.moreVertical,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
