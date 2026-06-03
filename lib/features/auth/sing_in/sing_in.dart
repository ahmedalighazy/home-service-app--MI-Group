import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/image/app_assets.dart';
import '../../../core/themes/text/app_text.dart';
import '../../../core/utils/l10n/app_strings.dart';
import '../../../core/widgets/language_toggle.dart';
import '../logic/cubits/auth_cubit.dart';
import '../logic/states/auth_state.dart';
import '../presentation/widgets/auth_or_divider.dart';
import '../presentation/widgets/auth_primary_button.dart';
import '../presentation/widgets/auth_social_button.dart';
import '../presentation/widgets/auth_text_field.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _rememberMe = false;
  bool _hasError = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _emailCtrl.text.trim().isNotEmpty && _passwordCtrl.text.isNotEmpty;

  void _onLogin(BuildContext context) {
    if (!_canSubmit) return;
    setState(() => _hasError = false);
    context.read<AuthCubit>().loginWithEmail(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
    );
  }

  void _onFieldChanged(String _) => setState(() => _hasError = false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.dark,
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            // Language Toggle in top right
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: const LanguageToggle(),
              ),
            ),
          ],
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: _handleState,
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.h),

                      // ── Title ────────────────────────────────────
                      Text(
                        AppStrings.welcomeBackAlt,
                        textAlign: TextAlign.right,
                        style: AppText.ibmHeading22(color: AppColors.dark),
                      ),

                      SizedBox(height: 32.h),

                      // ── Email ────────────────────────────────────
                      AuthTextField(
                        label: AppStrings.emailLabel,
                        hint: AppStrings.emailPlaceholder,
                        controller: _emailCtrl,
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: _onFieldChanged,
                      ),

                      SizedBox(height: 16.h),

                      // ── Password ─────────────────────────────────
                      AuthTextField(
                        label: AppStrings.passwordLabel,
                        hint: AppStrings.passwordPlaceholder,
                        controller: _passwordCtrl,
                        prefixIcon: Icons.lock_outline_rounded,
                        isPassword: true,
                        hasError: _hasError,
                        errorMessage: AppStrings.errorIncorrectPassword,
                        onChanged: _onFieldChanged,
                      ),

                      SizedBox(height: 24.h),

                      // ── Login Button ─────────────────────────────
                      AuthPrimaryButton(
                        label: AppStrings.login,
                        isLoading: isLoading,
                        onPressed: () => _onLogin(context),
                      ),

                      SizedBox(height: 16.h),

                      // ── Remember me & Forgot password ────────────
                      _RememberAndForgot(
                        rememberMe: _rememberMe,
                        onRememberChanged: (v) =>
                            setState(() => _rememberMe = v ?? false),
                        onForgotTap: () =>
                            context.push(AppRouter.forgetPassword),
                      ),

                      SizedBox(height: 32.h),

                      // ── Or divider ───────────────────────────────
                      const AuthOrDivider(),

                      SizedBox(height: 24.h),

                      // ── Google ───────────────────────────────────
                      AuthSocialButton(
                        iconPath: AppAssets.iconGoogle,
                        label: AppStrings.signUpWithGoogle,
                        onPressed: () {},
                      ),

                      SizedBox(height: 12.h),

                      // ── Apple ────────────────────────────────────
                      AuthSocialButton(
                        iconPath: AppAssets.iconApple,
                        label: AppStrings.signUpWithApple,
                        onPressed: () {},
                      ),

                      SizedBox(height: 32.h),

                      // ── Sign up link ─────────────────────────────
                      _SignUpRow(onTap: () => context.go(AppRouter.signUp)),

                      SizedBox(height: 16.h),

                      // ── Terms ────────────────────────────────────
                      Text(
                        AppStrings.termsAndPrivacy,
                        textAlign: TextAlign.center,
                        style: AppText.ibmCaption11(color: AppColors.gray),
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleState(BuildContext context, AuthState state) {
    if (state is SignInSuccess) {
      setState(() => _hasError = false);
      context.go(AppRouter.home);

      // ── Wrong email / password ───────────────────────────
    } else if (state is SignInInvalidCredentials) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppStrings.errorIncorrectPassword,
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

      // ── Network / server error ───────────────────────────
    } else if (state is SignInError) {
      setState(() => _hasError = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────
//  Remember me row + forgot password link
// ─────────────────────────────────────────────────────────────
class _RememberAndForgot extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotTap;

  const _RememberAndForgot({
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onForgotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me
        Row(
          children: [
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: Checkbox(
                value: rememberMe,
                activeColor: AppColors.greenPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                onChanged: onRememberChanged,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              AppStrings.rememberMe,
              style: AppText.ibmDescription14(color: AppColors.dark),
            ),
          ],
        ),

        // Forgot password
        GestureDetector(
          onTap: onForgotTap,
          child: Text(
            AppStrings.forgotPassword,
            style: AppText.ibmLink13(color: AppColors.greenPrimary),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  "Don't have an account? Create one" row
// ─────────────────────────────────────────────────────────────
class _SignUpRow extends StatelessWidget {
  final VoidCallback onTap;
  const _SignUpRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            AppStrings.createAccount,
            style: AppText.ibmLink13(color: AppColors.greenPrimary),
          ),
        ),
      ],
    );
  }
}
