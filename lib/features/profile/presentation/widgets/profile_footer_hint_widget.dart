import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

import '../../../../core/themes/text/app_text.dart';

class ProfileFooterHintWidget extends StatelessWidget {
  const ProfileFooterHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: ShapeDecoration(
        color: AppColors.inputBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 18.r, color: AppColors.textLightGrey),
          horizontalSpace(8),
          Expanded(
            child: Text(
              context.tr(LocaleKeys.profileFooterHint),
              style: AppText.ibmDescription14(),
            ),
          ),
        ],
      ),
    );
  }
}
