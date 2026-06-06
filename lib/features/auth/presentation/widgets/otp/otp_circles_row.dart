import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class OtpCirclesRow extends StatelessWidget {
  final String digits;
  final int length;
  final bool hasError;
  final Animation<double> shakeAnimation;

  const OtpCirclesRow({
    super.key,
    required this.digits,
    required this.length,
    required this.hasError,
    required this.shakeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(shakeAnimation.value, 0),
          child: child,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (index) {
          final hasDigit = index < digits.length;
          final isLastFilled = hasDigit && index == digits.length - 1;
          final isError = hasError && hasDigit;

          Color borderColor;
          Color textColor;
          double borderWidth;

          if (isError) {
            borderColor = AppColors.errorRed;
            textColor = AppColors.errorRed;
            borderWidth = 1.5;
          } else if (hasDigit) {
            textColor = AppColors.greenPrimary;
            if (isLastFilled) {
              borderColor = AppColors.greenPrimary;
              borderWidth = 1.5;
            } else {
              borderColor = Colors.transparent;
              borderWidth = 0;
            }
          } else {
            borderColor = AppColors.borderInputs;
            textColor = AppColors.primaryText;
            borderWidth = 1.5;
          }

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              border: Border.all(color: borderColor, width: borderWidth),
            ),
            alignment: Alignment.center,
            child: hasDigit
                ? Text(
                    digits[index],
                    style: AppText.ibmHeading22(color: textColor)
                        .copyWith(fontSize: 20.sp),
                  )
                : null,
          );
        }),
      ),
    );
  }
}
