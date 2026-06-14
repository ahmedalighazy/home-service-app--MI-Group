import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';
import 'popup_menu_button.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentMethodModel paymentMethod;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PaymentCardWidget({
    super.key,
    required this.paymentMethod,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingSmall.r),
      decoration: ShapeDecoration(
        color: AppColors.bgSecondary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.borderCards),
          borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 32.w,
            child: CustomPopupMenu(
              onSelected: (action) {
                switch (action) {
                  case MenuAction.edit:
                    onEdit();
                    break;
                  case MenuAction.delete:
                    onDelete();
                    break;
                  case MenuAction.favorite:
                    break;
                }
              },
            ),
          ),
          horizontalSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (paymentMethod.isDefault) const _DefaultBadge(),
                    const Spacer(),
                    Text(
                      '**** ${paymentMethod.lastFourDigits}',
                      style: AppText.ibmHeading14(color: AppColors.black),
                    ),
                  ],
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppStrings.expiresIn} ${paymentMethod.expiryDate}',
                      style: AppText.ibmDescription12(
                        color: AppColors.textLightGrey,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        paymentMethod.cardHolderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.ibmDescription12(
                          color: AppColors.textLightGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          horizontalSpace(8),
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Center(
              child: SvgPicture.asset(
                paymentMethod.iconPath,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  const _DefaultBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.badgeCyan,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall.r),
      ),
      child: Text(
        AppStrings.defaultText,
        style: AppText.ibmDescription12(
          color: AppColors.white,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
