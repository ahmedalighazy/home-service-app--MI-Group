import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          SizedBox(
            width: 48.w,
            child: SvgPicture.asset(
              paymentMethod.iconPath,
              fit: BoxFit.contain,
            ),
          ),
          horizontalSpace(12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '**** ${paymentMethod.lastFourDigits}',
                      style: AppText.ibmHeading16(color: AppColors.black),
                    ),
                    const Spacer(),
                    if (paymentMethod.isDefault)
                      _buildDefaultBadge(),
                    horizontalSpace(8),
                    InkWell(
                      onTap: onMoreTap,
                      child: SvgPicture.asset(
                        IconsPath.moreVertical,
                        width: 18.w,
                        height: 18.h,
                        colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      paymentMethod.cardHolderName,
                      style: AppText.ibmDescription14(color: AppColors.textLightGrey),
                    ),
                    Text(
                      'تنتهي في ${paymentMethod.expiryDate}',
                      style: AppText.ibmDescription14(color: AppColors.textLightGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF53AABF), // The teal color from image
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'افتراضي',
        style: AppText.ibmDescription12(color: AppColors.white).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
