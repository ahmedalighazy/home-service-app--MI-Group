import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              IconsPath
                  .container,
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
      ],
    );
  }
}
