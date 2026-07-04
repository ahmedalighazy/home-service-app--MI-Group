import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/sign_up/widgets/guest_mode_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_footer_link.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_or_divider.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_social_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/terms_and_privacy_text.dart';

import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/utils/l10n/localization_service.dart';
import '../../../../listeners/register_bloc_listener.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final isLoading = state is OtpSendLoading;
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.h),
              Text(
                context.tr('welcomeSignUp'),
                // textAlign: TextAlign.end,
                style: AppText.ibmHeading22(color: AppColors.dark),
              ),
              verticalSpace(32.h),
              AuthTextField(
                label: context.tr('emailLabel'),
                hint: context.tr('emailPlaceholder'),
                controller: context.read<RegisterCubit>().signUpEmailCtrl,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                hasError: false,
                onChanged: (_) {},
              ),
              verticalSpace(24.h),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: context.read<RegisterCubit>().signUpEmailCtrl,
                builder: (context, value, _) => AuthPrimaryButton(
                  label: context.tr('sendCode'),
                  isLoading: isLoading,
                  isEnabled: value.text.isNotEmpty,
                  onPressed: () =>
                      context.read<RegisterCubit>().sendSignUpSmsCode(),
                ),
              ),
              verticalSpace(12.h),
              Text(
                context.tr('verificationMethodInfo'),
                textAlign: TextAlign.center,
                style: AppText.ibmCaption11(color: AppColors.secondaryText),
              ),
              verticalSpace(24.h),
              const AuthOrDivider(),
              verticalSpace(24.h),
              AuthSocialButton(
                iconPath: AppAssets.iconGoogle,
                text: context.tr('signUpWithGoogle'),
                onTap: () {},
              ),
              verticalSpace(12.h),
              AuthSocialButton(
                iconPath: AppAssets.iconApple,
                text: context.tr('signUpWithApple'),
                onTap: () {},
              ),
              verticalSpace(24.h),
              Center(child: GuestModeButton(onTap: () {})),
              verticalSpace(16.h),
              AuthFooterLink(
                questionText: context.tr('alreadyHaveAccount'),
                actionText: context.tr('login'),
                onTap: () {
                  context.go(AppRouter.signIn);
                },
              ),
              verticalSpace(40.h),
              const TermsAndPrivacyText(),
              verticalSpace(32.h),
              const RegisterBlocListener(),
            ],
          ),
        );
      },
    );
  }
}
