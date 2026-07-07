import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorMessage;
  final bool hasError;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String countryCode;
  final String countryFlag;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.errorMessage,
    this.hasError = false,
    this.onChanged,
    this.hintText = '5123 4567',
    this.countryCode = '+974',
    this.countryFlag = '🇶🇦',
  });

  Color get _borderColor {
    if (hasError) return AppColors.errorRed;
    if (controller.text.isNotEmpty) return AppColors.greenPrimary;
    return AppColors.borderInputs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: hasError ? 1.5 : 1),
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.gray,
                      size: 20.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      countryCode,
                      style: AppText.ibmDescription14(
                        color: AppColors.dark,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8.w),
                    Text(countryFlag, style: TextStyle(fontSize: 18.sp)),
                  ],
                ),
              ),
              Container(height: 30.h, width: 1, color: AppColors.borderInputs),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.left,
                    style: AppText.ibmDescription14(color: AppColors.dark),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      hintText: hintText,
                      hintStyle: AppText.ibmDescription14(
                        color: AppColors.placeholder,
                      ),
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ),
              if (controller.text.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      controller.clear();
                      onChanged?.call('');
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: AppColors.gray,
                      size: 20.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (hasError && errorMessage != null) ...[
          SizedBox(height: 6.h),
          Text(
            errorMessage!,
            style: AppText.ibmCaption11(color: AppColors.errorRed),
          ),
        ],
      ],
    );
  }
}
