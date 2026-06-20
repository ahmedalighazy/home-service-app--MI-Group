import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

import '../../themes/colors/app_colors.dart';
import '../../themes/text/app_text.dart';
import '../../widgets/custom_action_buttom.dart';
import '../../widgets/custom_buttom.dart';

void showCannotDeleteDialogred(
  BuildContext context,
  String title,
  String content, [
  String? titleButtom,
  bool isImageLgout = false,
]) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: context.isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.all(20.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                isImageLgout ? IconsPath.logOutDilaog : IconsPath.group40383Svg,
              ),
              verticalSpace(12),
              Text(
                title,
                style: AppText.boldIbm(color: AppColors.black, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              verticalSpace(12),
              Text(
                content,
                style: AppText.regularIbm(
                  color: AppColors.textLightGrey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(24),
              Row(
                children: [
                  Expanded(
                    child: CustomActionButton(
                      text: context.tr(LocaleKeys.profileDeleteAction),
                      backgroundColor: AppColors.red,
                      textColor: AppColors.white,
                      onTap: () {
                        // delete action
                      },
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: CustomActionButton(
                      text: context.tr(
                        LocaleKeys.profileDeleteAddressCancelBtn,
                      ),
                      backgroundColor: AppColors.white,
                      textColor: AppColors.primaryGrey,
                      onTap: () {
                        // edit action
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showCannotDeleteDialog(
  BuildContext context,
  String title,
  String content,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: context.isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.all(20.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppText.boldIbm(color: AppColors.black, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              verticalSpace(12),
              Text(
                content,
                style: AppText.regularIbm(
                  color: AppColors.textLightGrey,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(24),
              CustomButtom(
                onTap: () => context.pop(),
                // text: context.tr(LocaleKeys.ok),
                text: context.l10n.okBtn,
                textStyle: AppText.ibmButton16(),
                startColor: AppColors.primary,
                endColor: AppColors.primaryActive,
              ),
            ],
          ),
        ),
      );
    },
  );
}
