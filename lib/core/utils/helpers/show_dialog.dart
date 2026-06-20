import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../themes/colors/app_colors.dart';
import '../../themes/text/app_text.dart';
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
        textDirection: TextDirection.rtl,
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
              Text(
                title,
                style: AppText.boldIbm(color: AppColors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                content,
                style: AppText.regularIbm(
                  color: AppColors.textLightGrey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: width(context) / 3.4,
                      height: 40.h,

                      decoration: ShapeDecoration(
                        color: const Color(0xFFD2503C) /* border-warning-2 */,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          titleButtom ?? 'حذف ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFF8FAFC) /* text-inverse */,
                            fontSize: 16,
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: width(context) / 3.4,
                      height: 48.h,

                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFE5E7EB) /* border-inputs */,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'الغاء ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF6D7688),
                            fontSize: 16,
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
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
        textDirection: TextDirection.rtl,
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
                style: AppText.boldIbm(color: AppColors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                content,
                style: AppText.regularIbm(
                  color: AppColors.textLightGrey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              CustomButtom(
                onTap: () => context.pop(),
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
