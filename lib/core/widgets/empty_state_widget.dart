import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';

class EmptyStateWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool? isscreenBooking;

  const EmptyStateWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButtonPressed,
    this.isscreenBooking = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingXL.w),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: isscreenBooking! ? 150.w : 200.w,
              height: isscreenBooking! ? 150.h : 200.h,
            ),
            SizedBox(height: AppSizes.spacingMedium.h),
            Text(
              title,
              style: AppText.ibmHeading20(color: AppColors.primaryText),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingSmall.h),
            Text(
              subtitle,
              style: AppText.ibmDescription14(),
              textAlign: TextAlign.center,
            ),
            if (buttonLabel != null && onButtonPressed != null) ...[
              SizedBox(height: 10),
              CustomButtom(
                onTap: onButtonPressed!,
                text: buttonLabel!,
                textStyle: AppText.ibmButton16(),
                startColor: AppColors.primary,
                endColor: AppColors.primaryActive,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
