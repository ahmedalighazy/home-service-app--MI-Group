import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

class CustomWidgetDelete extends StatelessWidget {
  const CustomWidgetDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppText.mediumIbm(
          color: AppColors.primaryText,
          fontSize: 14.sp,
        ).copyWith(height: 1.5),
        children: [
          TextSpan(text: context.tr(LocaleKeys.profileDeleteConfirmHint)),
          TextSpan(
            text: context.tr(LocaleKeys.profileDeleteConfirmWord),
            style: AppText.boldIbm(color: AppColors.redDanger, fontSize: 14.sp),
          ),
          const TextSpan(text: ' )'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
