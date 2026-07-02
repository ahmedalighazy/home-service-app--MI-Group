import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'new_pass_btn_data.dart';
import 'set_new_widgets.dart';

class NewPasswordConfirmButton extends StatelessWidget {
  final String email;
  final String code;

  const NewPasswordConfirmButton({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    return BlocSelector<
      ForgotPasswordCubit,
      ForgotPasswordState,
      NewPassBtnData
    >(
      selector: (s) => NewPassBtnData(
        isLoading: s is PasswordResetLoading,
        isSuccess: s is PasswordResetSuccess,
        isPasswordsValid: cubit.isPasswordsValid,
      ),
      builder: (context, data) {
        return SetNewPasswordButton(
          isSuccess: data.isSuccess,
          isLoading: data.isLoading,
          onPressed: data.isPasswordsValid
              ? () {
                  cubit.resetPassword(
                    email: email,
                    otp: code,
                    newPassword: cubit.newPasswordCtrl.text,
                  );
                }
              : null,
        );
      },
    );
  }
}
