import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class OtpNumericKeyboard extends StatelessWidget {
  final ValueChanged<String> onDigitTap;
  final VoidCallback onDeleteTap;

  const OtpNumericKeyboard({
    super.key,
    required this.onDigitTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD1D5DB),
      padding: EdgeInsets.fromLTRB(6.w, 8.h, 6.w, 10.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final row in [
              ['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9'],
              ['', '0', 'del'],
            ])
              Padding(
                padding: EdgeInsets.only(bottom: 7.h),
                child: Row(
                  children: row.map((key) {
                    if (key.isEmpty) {
                      return Expanded(child: SizedBox(height: 48.h));
                    }
                    if (key == 'del') {
                      return Expanded(
                        child: _Key(
                          icon: Icons.backspace_outlined,
                          onTap: onDeleteTap,
                        ),
                      );
                    }
                    return Expanded(
                      child: _Key(
                        label: key,
                        onTap: () => onDigitTap(key),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Key extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  const _Key({this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: SizedBox(
            height: 48.h,
            child: Center(
              child: label != null
                  ? Text(
                      label!,
                      style: AppText.ibmHeading22(color: AppColors.primaryText)
                          .copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Icon(icon, size: 22.sp, color: AppColors.primaryText),
            ),
          ),
        ),
      ),
    );
  }
}
