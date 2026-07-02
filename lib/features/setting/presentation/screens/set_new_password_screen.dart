import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/custom_buttom.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/features/profile/presentation/cubit/profile_cubit.dart';

import '../widgets/forget_password_link.dart';
import '../widgets/password_text_field.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onChangePassword(BuildContext context) {
    final current = _currentPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول'), backgroundColor: AppColors.redDanger),
      );
      return;
    }

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة المرور الجديدة غير متطابقة'), backgroundColor: AppColors.redDanger),
      );
      return;
    }

    context.read<ProfileCubit>().changePassword(
      currentPassword: current,
      newPassword: newPass,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(title: ''),
        body: SafeArea(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ChangePasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح ✓'), backgroundColor: AppColors.greenPrimary),
                );
                context.pop();
              } else if (state is ChangePasswordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message), backgroundColor: AppColors.redDanger),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is ChangePasswordLoading;
              
              return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(24),
              Text(
                context.tr(LocaleKeys.settingsSetNewPassword),
                style: AppText.ibmHeading20(color: AppColors.primaryText),
              ),
              verticalSpace(8),
              Text(
                context.tr(LocaleKeys.settingsEditPassDescription),
                style: AppText.ibmDescription14(color: AppColors.body),
              ),
              verticalSpace(32),
              PasswordTextField(
                controller: _currentPasswordController,
                label: context.tr(LocaleKeys.settingsPasswordNow),
                hintText: context.tr(LocaleKeys.settingsEnterPassword),
              ),
              const ForgetPasswordLink(),
              verticalSpace(16),
              PasswordTextField(
                controller: _newPasswordController,
                label: context.tr(LocaleKeys.settingsNewPassword),
                hintText: context.tr(LocaleKeys.settingsEnterPassword),
              ),
              verticalSpace(16),
              PasswordTextField(
                controller: _confirmPasswordController,
                label: context.tr(LocaleKeys.settingsConfirmPassword),
                hintText: context.tr(LocaleKeys.settingsReEnterPassword),
              ),
              const Spacer(),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButtom(
                      text: context.tr(LocaleKeys.settingsConfirm),
                      onTap: () => _onChangePassword(context),
                      startColor: AppColors.primary,
                      endColor: AppColors.primary,
                      textStyle: AppText.ibmButton16(color: AppColors.softWhite),
                    ),
              verticalSpace(20),
            ],
          ),
        );
      },
    ),
  ),
),
    );
  }
}
