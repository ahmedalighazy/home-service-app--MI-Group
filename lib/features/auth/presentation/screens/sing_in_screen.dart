import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_or_divider.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_social_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_in/remember_forgot_row.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_in/sign_up_link_row.dart';

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
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.dark),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: _handleState,
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            final isArabic = Localizations.localeOf(context).languageCode == 'ar';

            return Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
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
                      RememberForgotRow(
                        rememberMe: _rememberMe,
                        onRememberChanged: (v) =>
                            setState(() => _rememberMe = v ?? false),
                        onForgotTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.forgetPassword),
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
                      SignUpLinkRow(
                        onTap: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.login);
                          }
                        },
                      ),

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
    if (state is AuthError) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.message,
            style: AppText.ibmDescription14(color: AppColors.white),
          ),
          backgroundColor: AppColors.errorRed,
        ),
      );
    } else if (state is AuthSuccess) {
      setState(() => _hasError = false);
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }
}
