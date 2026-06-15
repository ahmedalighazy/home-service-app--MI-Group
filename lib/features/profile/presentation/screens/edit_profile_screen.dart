import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/profile_image_edit_widget.dart';
import '../widgets/profile_footer_hint_widget.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.editProfile),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const ProfileImageEditWidget(),
            SizedBox(height: 24.h),
            const EditProfileForm(),
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
                context.pushNamed(AppRouter.deleteAccount);
              },
            ),
            SizedBox(height: 24.h),
            const ProfileFooterHintWidget(),
          ],
        ),
      ),
    );
  }
}
