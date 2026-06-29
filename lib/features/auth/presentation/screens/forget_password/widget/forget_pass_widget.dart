import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/image/app_assets.dart';
import '../../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/forget_password_cubit.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class ForgetHeader extends StatelessWidget {
  const ForgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
          context.tr('resetPassword'),
          textAlign: TextAlign.center,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        SizedBox(height: 10.h),
        Text(
          context.tr('resetPasswordDescription'),
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
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        final cubit = context.read<ForgetPasswordCubit>();
        return AuthTextField(
          label: context.tr('emailLabel'),
          hint: context.tr('emailLabel'),
          controller: controller,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          hasError: cubit.hasError,
          errorMessage: context.tr('invalidEmail'),
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
          bloc: getIt<AuthCubit>(),
          builder: (context, authState) {
            final isLoading = authState is AuthLoadingState;
            return AuthPrimaryButton(
              label: context.tr('sendCode'),
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
