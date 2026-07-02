import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';
import '../cubit/profile_cubit.dart';

class EditProfileForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const EditProfileForm({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  bool _prefilled = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // Pre-fill controllers once when data is loaded
        if (state is ProfileLoaded && !_prefilled) {
          _prefilled = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.nameController.text = state.profile.name ?? '';
            widget.phoneController.text = state.profile.phone ?? '';
            widget.emailController.text = state.profile.email ?? '';
          });
        }

        return Column(
          children: [
            CustomTextField(
              fillColor: AppColors.dark300,
              label: context.tr(LocaleKeys.profileNameLabel),
              controller: widget.nameController,
              hintText: context.tr(LocaleKeys.profileNameLabel),
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(IconsPath.profile, height: 3, width: 1),
              ),
            ),
            verticalSpace(16),
            CustomTextField(
              fillColor: AppColors.dark300,
              label: context.tr(LocaleKeys.profilePhoneLabel),
              controller: widget.phoneController,
              hintText: context.tr(LocaleKeys.profilePhoneLabel),
              keyboardType: TextInputType.phone,
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  IconsPath.container,
                  height: 3,
                  width: 1,
                ),
              ),
            ),
            verticalSpace(16),
            CustomTextField(
              fillColor: AppColors.dark300,
              label: context.tr(LocaleKeys.profileEmailLabel),
              controller: widget.emailController,
              hintText: context.tr(LocaleKeys.profileEmailLabel),
              keyboardType: TextInputType.emailAddress,
              isReadOnly: true, // البريد الإلكتروني للقراءة فقط
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(IconsPath.email, height: 3, width: 1),
              ),
            ),
          ],
        );
      },
    );
  }
}
