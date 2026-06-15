import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart'
    show AppColors;
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

import '../../../../core/constants/icons_path.dart';
import '../../../../core/themes/text/app_text.dart';

class CancelChat extends StatelessWidget {
  const CancelChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF) /* bg-secondary */,
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 6,
        children: [
          Container(
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 13.r, vertical: 5.r),

            decoration: ShapeDecoration(
              // color: Colors.white /* white */,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFFE5E7EB) /* border-inputs */,
                ),
                borderRadius: BorderRadius.circular(44),
              ),
            ),
            child: Row(
              spacing: 10,
              children: [
                SvgPicture.asset(IconsPath.exit, width: 15.w, height: 15.h),
                Text(
                  context.tr(LocaleKeys.helpCenterReopenTicket),
                  textAlign: TextAlign.center,
                  style: AppText.ibmHeading14(color: AppColors.greenPrimary),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            context.tr(LocaleKeys.helpCenterReadOnlyChat),
            style: AppText.ibmHeading14(
              color: AppColors.textLightGrey,
            ).copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
