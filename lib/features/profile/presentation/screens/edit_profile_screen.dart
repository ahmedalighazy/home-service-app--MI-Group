import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/profile_image_edit_widget.dart';
import '../widgets/profile_footer_hint_widget.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      _showSnackBar(context, 'من فضلك أدخل الاسم', isError: true);
      return;
    }

    context.read<ProfileCubit>().updateProfile(
          name: name.isNotEmpty ? name : null,
          phone: phone.isNotEmpty ? phone : null,
        );
  }

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.redDanger : AppColors.greenPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            // Refresh the profile data after successful update
            getIt<ProfileCubit>().getProfile();
            _showSnackBar(context, 'تم تحديث البروفايل بنجاح ✓');
            context.pop();
          } else if (state is ProfileUpdateError) {
            _showSnackBar(context, state.message, isError: true);
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfileUpdateLoading;

          return Scaffold(
            appBar: CustomAppBar(title: context.tr(LocaleKeys.profileEdit)),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  verticalSpace(16),
                  const ProfileImageEditWidget(),
                  verticalSpace(24),
                  EditProfileForm(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                  ),
                  verticalSpace(24),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          backgroundColor: AppColors.greenPrimary,
                          onPressed: () => _onSave(context),
                          textColor: AppColors.white,
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
        },
      ),
    );
  }
}
