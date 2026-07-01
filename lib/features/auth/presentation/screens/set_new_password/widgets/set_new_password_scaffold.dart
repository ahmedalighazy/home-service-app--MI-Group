import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'set_new_widgets.dart';

class SetNewPasswordScaffold extends StatefulWidget {
  final String email;
  final String code;

  const SetNewPasswordScaffold({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<SetNewPasswordScaffold> createState() => _SetNewPasswordScaffoldState();
}

class _SetNewPasswordScaffoldState extends State<SetNewPasswordScaffold> {
  @override
  void initState() {
    super.initState();
    context.read<ForgotPasswordCubit>().initPasswordListeners();
  }

  @override
  void dispose() {
    context.read<ForgotPasswordCubit>().disposePasswordListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CustomBackArrowButton(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          context.tr('setNewPasswordTitle'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.tr('setNewPasswordDescription'),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        BlocSelector<
                          ForgotPasswordCubit,
                          ForgotPasswordState,
                          Color
                        >(
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
                                hintText: context.tr(
                                  'confirmPasswordPlaceholder',
                                ),
                                controller: cubit.confirmPasswordCtrl,
                                obscureText: false,
                                borderColor: borderColor,
                                onObscurePressed: () {},
                              ),
                            ],
                          ),
                        ),
                        BlocSelector<
                          ForgotPasswordCubit,
                          ForgotPasswordState,
                          bool
                        >(
                          selector: (_) => cubit.isNewPasswordError(),
                          builder: (context, isError) {
                            if (!isError) return const SizedBox.shrink();
                            return const SetNewPasswordErrorText();
                          },
                        ),
                        const Spacer(),
                        const SizedBox(height: 20),
                        BlocSelector<
                          ForgotPasswordCubit,
                          ForgotPasswordState,
                          _NewPassBtnData
                        >(
                          selector: (s) => _NewPassBtnData(
                            isLoading: s is PasswordResetLoading,
                            isSuccess: s is PasswordResetSuccess,
                            isPasswordsValid: cubit.isPasswordsValid,
                          ),
                          builder: (context, data) {
                            // log(isPasswordsValid.);
                            return SetNewPasswordButton(
                              isSuccess: data.isSuccess,
                              isLoading: data.isLoading,
                              onPressed: data.isPasswordsValid
                                  ? () {
                                      cubit.resetPassword(
                                        email: widget.email,
                                        otp: widget.code,
                                        newPassword: cubit.newPasswordCtrl.text,
                                      );
                                    }
                                  : null,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
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

class _NewPassBtnData extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isPasswordsValid;

  const _NewPassBtnData({
    required this.isLoading,
    required this.isSuccess,
    required this.isPasswordsValid,
  });

  @override
  List<Object?> get props => [isLoading, isSuccess, isPasswordsValid];
}
