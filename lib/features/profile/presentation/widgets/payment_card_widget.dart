import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/profile/data/models/payment_method_model.dart';

import 'popup_menu_button.dart';

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
      padding: EdgeInsets.all(8.r),
      decoration: ShapeDecoration(
        color: const Color(0xFFF8FBFF) /* bg-secondary */,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF1F5F9) /* border-cards */,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPopupMenu(
                onSelected: (action) {
                  switch (action) {
                    case MenuAction.favorite:
                      // Favorite
                      break;

                    case MenuAction.edit:
                      // Edit
                      break;

                    case MenuAction.delete:
                      // Delete
                      break;
                  }
                },
              ),
              // const Icon(Icons.power)
              verticalSpace(40),
            ],
          ),
          // SizedBox(
          //   width: 48.w,
          //   child: SvgPicture.asset(
          //     paymentMethod.iconPath,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          horizontalSpace(12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // const Icon(Icons.power),
                    if (paymentMethod.isDefault) _buildDefaultBadge(),
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
                      'تنتهي في ${paymentMethod.expiryDate ?? ''}',
                      style: AppText.ibmDescription12(
                        color: AppColors.textLightGrey,
                      ),
                    ),
                    Text(
                      paymentMethod.cardHolderName ?? '',
                      style: AppText.ibmDescription12(
                        color: AppColors.textLightGrey,
                      ).copyWith(overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ],
            ),
          ),
          horizontalSpace(8),
          InkWell(
            onTap: onMoreTap,
            child: SvgPicture.asset(
              paymentMethod.iconPath ?? '',

              width: 18.w,
              height: 18.h,
              // colorFilter: const ColorFilter.mode(
              //   AppColors.black,
              //   BlendMode.srcIn,
              // ),
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
        style: AppText.ibmDescription12(
          color: AppColors.white,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
