import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/image/app_assets.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../cubits/auth_cubit.dart';
import '../../../cubits/auth_state.dart';
import '../../../cubits/forget_password_cubit.dart';
import '../../../widgets/auth_back_button.dart';
import '../../../widgets/auth_primary_button.dart';
import '../../../widgets/auth_text_field.dart';

class ForgetHeader extends StatelessWidget {
  const ForgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerLeft,
          child: AuthBackButton(onTap: () => context.pop()),
        ),
        SizedBox(height: 32.h),
        Center(
          child: Image.asset(
            AppAssets.forgot,
            width: 200.w,
            height: 200.w,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          context.l10n.resetPassword,
          textAlign: TextAlign.center,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        SizedBox(height: 10.h),
        Text(
          context.l10n.resetPasswordDescription,
          textAlign: TextAlign.center,
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
      ],
    );
  }
}

class ForgetEmailField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ForgetEmailField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      buildWhen: (previous, current) =>
          // ignore: unnecessary_type_check
          current is ForgetPasswordInitial || current is ForgetPasswordState,
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();
        return AuthTextField(
          label: context.l10n.emailLabel,
          hint: context.l10n.emailPlaceholder,
          controller: controller,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          hasError: cubit.hasError,
          errorMessage: 'يرجى إدخال بريد إلكتروني صحيح',
          onChanged: onChanged,
        );
      },
    );
  }
}

class ForgetSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgetSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, forgetState) {
        final cubit = context.read<ForgetPasswordCubit>();
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            final isLoading = authState is AuthLoading;
            return AuthPrimaryButton(
              label: context.l10n.sendCode,
              isLoading: isLoading,
              isEnabled: cubit.isValid,
              onPressed: onPressed,
            );
          },
        );
      },
    );
  }
}
