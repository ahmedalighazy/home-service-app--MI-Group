import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
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
        color: const Color(0xFFF8FBFF),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(12),
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
                  case MenuAction.favorite:
                    break;
                  case MenuAction.edit:
                    break;
                  case MenuAction.delete:
                    break;
                }
              },
            ),
          ),

          SizedBox(width: 8.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (paymentMethod.isDefault) _buildDefaultBadge(),

                    const Spacer(),

                    Text(
                      '**** ${paymentMethod.lastFourDigits}',
                      style: AppText.ibmHeading14(color: AppColors.black),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                /// تركنا الـ Row كما هو
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تنتهي في ${paymentMethod.expiryDate}',
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

          SizedBox(width: 8.w),

          SizedBox(
            width: 32.w,
            height: 32.h,
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

  Widget _buildDefaultBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF53AABF),
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
