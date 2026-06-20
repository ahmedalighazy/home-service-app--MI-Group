import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

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
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              context.l10n.footerHint,
              style: AppText.ibmDescription14(),
            ),
          ),
        ],
      ),
    );
  }
}
