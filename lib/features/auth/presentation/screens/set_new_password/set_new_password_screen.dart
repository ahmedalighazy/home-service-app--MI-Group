import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'widget/set_new_widgets.dart';
import 'widgets/set_new_password_bloc_listener.dart';

class SetNewPasswordScreen extends StatelessWidget {
  final String email;
  final String code;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isLoading = cubit.state is AuthLoadingState;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.state is! AuthInitial && cubit.state is! AuthLoadingState && cubit.state is! PasswordResetSuccessState) {
        cubit.resetState();
      }
    });

    final isError = cubit.isNewPasswordError();
    final isSuccess = cubit.isNewPasswordSuccess();

    Color getBorderColor() {
      if (isError) return AppColors.errorRed;
      if (isSuccess) return AppColors.greenPrimary;
      return AppColors.borderInputs;
    }

    return SetNewPasswordBlocListener(
      child: Scaffold(
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
                          Text(context.tr('setNewPasswordTitle'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 8),
                          Text(context.tr('setNewPasswordDescription'), style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.5)),
                          const SizedBox(height: 32),
                          PasswordInputField(
                            title: context.tr('passwordLabel'),
                            hintText: context.tr('passwordPlaceholder'),
                            controller: cubit.newPasswordCtrl,
                            obscureText: cubit.uiState.obscureNewPassword,
                            borderColor: getBorderColor(),
                            onObscurePressed: cubit.toggleNewPasswordObscure,
                          ),
                          const SizedBox(height: 20),
                          PasswordInputField(
                            title: context.tr('confirmPasswordLabel'),
                            hintText: context.tr('confirmPasswordPlaceholder'),
                            controller: cubit.confirmPasswordCtrl,
                            obscureText: cubit.uiState.obscureConfirmNewPassword,
                            borderColor: getBorderColor(),
                            onObscurePressed: cubit.toggleConfirmNewPasswordObscure,
                          ),
                          if (isError) const SetNewPasswordErrorText(),
                          const Spacer(),
                          const SizedBox(height: 20),
                          SetNewPasswordButton(
                            isSuccess: isSuccess,
                            isLoading: isLoading,
                            onPressed: () {
                              final pass = cubit.newPasswordCtrl.text;
                              if (pass.isEmpty || pass != cubit.confirmPasswordCtrl.text) return;
                              cubit.resetPassword(email: email, code: code, newPassword: pass);
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
      ),
    );
  }
}
