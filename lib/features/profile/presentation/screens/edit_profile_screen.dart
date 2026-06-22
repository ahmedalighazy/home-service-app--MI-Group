import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            verticalSpace(16),
            const ProfileImageEditWidget(),
            verticalSpace(24),
            const EditProfileForm(),
            verticalSpace(24),
            CustomButton(
              backgroundColor: AppColors.bgDisabled,
              onPressed: () {

              },
              textColor: AppColors.whitecancel,
              isOutlined: false,
              text: context.tr(LocaleKeys.profileSave),
            ),
            verticalSpace(24),
            CustomButton(
              text: context.tr(LocaleKeys.profileDeleteAccount),
              backgroundColor: AppColors.redDangerBg,
              textColor: AppColors.redDanger,
              isOutlined: true,
              onPressed: () {
                context.pushNamed(AppRouter.deleteAccount);
              },
            ),
            verticalSpace(24),
            const ProfileFooterHintWidget(),
          ],
        ),
      ),
    );
  }
}
