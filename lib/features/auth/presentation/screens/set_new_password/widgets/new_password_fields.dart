import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'password_input_field.dart';
import 'set_new_password_error_text.dart';

class NewPasswordFields extends StatelessWidget {
  const NewPasswordFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    return Column(
      children: [
        BlocSelector<ForgotPasswordCubit, ForgotPasswordState, Color>(
          selector: (_) => _borderColor(cubit),
          builder: (context, borderColor) => Column(
            children: [
              PasswordInputField(
                title: context.tr('passwordLabel'),
                hintText: context.tr('passwordPlaceholder'),
                controller: cubit.newPasswordCtrl,
                obscureText: false,
                borderColor: borderColor,
                onObscurePressed: () {},
              ),
              SizedBox(height: 20.h),
              PasswordInputField(
                title: context.tr('confirmPasswordLabel'),
                hintText: context.tr('confirmPasswordPlaceholder'),
                controller: cubit.confirmPasswordCtrl,
                obscureText: false,
                borderColor: borderColor,
                onObscurePressed: () {},
              ),
            ],
          ),
        ),
        BlocSelector<ForgotPasswordCubit, ForgotPasswordState, bool>(
          selector: (_) => cubit.isNewPasswordError(),
          builder: (context, isError) {
            if (!isError) return const SizedBox.shrink();
            return const SetNewPasswordErrorText();
          },
        ),
      ],
    );
  }

  Color _borderColor(ForgotPasswordCubit cubit) {
    final isError = cubit.isNewPasswordError();
    final isSuccess = cubit.isNewPasswordSuccess();
    if (isError) return AppColors.errorRed;
    if (isSuccess) return AppColors.greenPrimary;
    return AppColors.borderInputs;
  }
}
