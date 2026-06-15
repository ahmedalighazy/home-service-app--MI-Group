import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

class ContactUsFooterNote extends StatelessWidget {
  const ContactUsFooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FCFF),
        borderRadius: BorderRadius.circular(AppSizes.radiusM.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            IconsPath.ok,
            colorFilter: const ColorFilter.mode(
              AppColors.dark,
              BlendMode.srcIn,
            ),
            width: 20.r,
            height: 20.r,
          ),
          horizontalSpace(12),
          Expanded(
            child: Text(
              context.tr(LocaleKeys.profilePrivacyConfidentialityNote),
              style: AppText.ibmDescription14(
                color: AppColors.textLightGrey,
              ).copyWith(height: 1.5),
            ),
          ),

        ],
      ),
    );
  }
}
