import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/icons_path.dart';
import '../../../../core/extensions/extention_navigator.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/image/app_assets.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../widgets/custom_buttom.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: const CustomAppBar(title: AppStrings.editProfile),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    // width: 80.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,

                          // width: width(context)*0.6,
                          // height: height(context) * 0.13,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 1,
                                color: AppColors.greenPrimary,
                              ),
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 48.r,
                            child: Image.asset(AppAssets.cleaningGuy),
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: -9,
                    right: 0,

                    child: CircleAvatar(
                      backgroundColor: AppColors.white,

                      radius: 20.r,
                      child: SvgPicture.asset(
                        IconsPath.edit,
                        // width: 16.r,
                        // height: 16.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CustomTextField(
              fillColor: AppColors.dark300,
              label: AppStrings.nameLabel,
              initialValue: AppStrings.profileName,
              hintText: '',
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(IconsPath.profile, height: 3, width: 1),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              fillColor: AppColors.dark300,

              label: AppStrings.phoneLabel,
              initialValue: AppStrings.phoneNumber,
              hintText: '',
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  IconsPath.container,
                  height: 3,
                  width: 1,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              fillColor: AppColors.dark300,

              label: AppStrings.emailLabel,
              initialValue: AppStrings.emailValue,
              hintText: '',
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(IconsPath.email, height: 3, width: 1),
              ),
            ),
            SizedBox(height: 24.h),

            CustomButton(
              backgroundColor: AppColors.bgDisabled,
              onPressed: () {
                // Handle save action
              },
              textColor: AppColors.whitecancel,
              isOutlined: false,

              text: AppStrings.save,
            ),

            SizedBox(height: 24.h),
            CustomButton(
              text: AppStrings.deleteAccountBtn,
              backgroundColor: AppColors.redDangerBg,
              textColor: AppColors.redDanger,
              isOutlined: true,
              onPressed: () {
                context.pushName(AppRoutes.deleteAccount);
                // الانتقال إلى شاشة تعليمات حذف الحساب
              },
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: ShapeDecoration(
                color: AppColors.inputBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.r,
                    color: AppColors.textLightGrey,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      AppStrings.footerHint,
                      style: AppText.regularIbm(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
