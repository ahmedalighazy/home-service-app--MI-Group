import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          fillColor: AppColors.dark300,
          label: context.tr(LocaleKeys.profileNameLabel),
          initialValue: context.tr(LocaleKeys.profileName),
          hintText: '',
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(IconsPath.profile, height: 3, width: 1),
          ),
        ),
        verticalSpace(16),
        CustomTextField(
          fillColor: AppColors.dark300,
          label: context.tr(LocaleKeys.profilePhoneLabel),
          initialValue: context.tr(LocaleKeys.profilePhoneNumber),
          hintText: '',
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              IconsPath
                  .container, // Assuming this was the intended icon from the original code (IconsPath.container)
              height: 3,
              width: 1,
            ),
          ),
        ),
        verticalSpace(16),
        CustomTextField(
          fillColor: AppColors.dark300,
          label: context.tr(LocaleKeys.profileEmailLabel),
          initialValue: 'ahmed.m@gmail.com', // Keep the actual value
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
