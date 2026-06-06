import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_or_divider.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_in/remember_forgot_row.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_in/sign_up_link_row.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_in/social_sign_in_buttons.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up/terms_and_privacy.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late final AuthCubit _authCubit;

  bool _rememberMe = true;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    // تحقق أبسط من صحة الإيميل
    return email.contains('@') && email.contains('.');
  }

  bool _isFormValid() {
    return _emailCtrl.text.trim().isNotEmpty &&
        _isValidEmail(_emailCtrl.text.trim()) &&
        _passwordCtrl.text.trim().length >= 4;
  }

  void _handleSignIn() {
    if (!_isFormValid()) {
      _showErrorSnackBar(AppStrings.errorFieldRequired);
      return;
    }

    _authCubit.login(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppStrings.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess ||
                    state is GoogleSignInSuccess ||
                    state is AppleSignInSuccess) {
                  _showSuccessMessage(AppStrings.loginWithNewPassword);
                  Future.delayed(const Duration(seconds: 1), () {
                    if (!context.mounted) return;
                    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                  });
                } else if (state is AuthError) {
                  _showErrorSnackBar(state.message);
                } else if (state is SocialSignInError) {
                  _showErrorSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.signUp),
                          child: Image.asset(
                            'assets/images/Frame 2147225973.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppStrings.welcomeBackAlt,
                        style: AppText.ibmHeading22(
                          color: AppColors.primaryText,
                        ),
                      ),
                      SizedBox(height: 28.h),
                      AuthFormField(
                        label: AppStrings.emailLabel,
                        hint: AppStrings.emailPlaceholder,
                        controller: _emailCtrl,
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 16.h),
                      AuthFormField(
                        label: AppStrings.passwordLabel,
                        hint: AppStrings.passwordPlaceholder,
                        controller: _passwordCtrl,
                        isPassword: true,
                        obscureText: !_passwordVisible,
                        onToggleObscure: () => setState(
                          () => _passwordVisible = !_passwordVisible,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 24.h),
                      AuthPrimaryButton(
                        label: AppStrings.login,
                        isLoading: state is AuthLoading,
                        isEnabled: _isFormValid(),
                        onPressed: _handleSignIn,
                      ),
                      SizedBox(height: 16.h),
                      RememberForgotRow(
                        rememberMe: _rememberMe,
                        onRememberChanged: (value) {
                          setState(() => _rememberMe = value ?? false);
                        },
                        onForgotTap: () =>
                            Navigator.of(context).pushNamed(AppRoutes.verifyResetCode),
                      ),
                      SizedBox(height: 24.h),
                      const AuthOrDivider(),
                      SizedBox(height: 24.h),
                      SocialSignInButtons(
                        onGoogleTap: () =>
                            _authCubit.signInWithGoogle(),
                        onAppleTap: () =>
                            _authCubit.signInWithApple(),
                      ),
                      SizedBox(height: 28.h),
                      SignUpLinkRow(
                        onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.signUp),
                      ),
                      SizedBox(height: 16.h),
                      const TermsAndPrivacy(),
                      SizedBox(height: 16.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
