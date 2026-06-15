import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
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
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: ShapeDecoration(
        color: AppColors.bgSecondary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.borderCards),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(context.isRtl ? 8.w : -8.w, -8.h),
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
                      style: AppText.boldIbm(
                        color: AppColors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.tr(LocaleKeys.profileExpiresIn)} ${paymentMethod.expiryDate}',
                      style: AppText.regularIbm(
                        color: AppColors.textLightGrey,
                        fontSize: 12.sp,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        paymentMethod.cardHolderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.mediumIbm(
                          color: AppColors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          horizontalSpace(12),
          Center(
            child: SvgPicture.asset(
              paymentMethod.iconPath,
              width: 32.w,
              height: 20.h,
              fit: BoxFit.contain,
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.badgeCyan,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        context.tr(LocaleKeys.profileDefault),
        style: AppText.mediumIbm(color: AppColors.white, fontSize: 10.sp),
      ),
    );
  }
}
