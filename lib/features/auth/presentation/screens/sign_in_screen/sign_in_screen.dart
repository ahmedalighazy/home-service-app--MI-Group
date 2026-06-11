import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../logic/validators/sign_in_validator.dart';
import '../../cubits/auth_cubit_v2.dart';
import '../../states/auth_state.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

// New UI Widgets
import '../../widgets/auth_text_field.dart';
import '../../widgets/auth_primary_button.dart';
import '../../widgets/auth_or_divider.dart';
import '../../widgets/sign_in/remember_forgot_row.dart';
import '../../widgets/sign_in/social_sign_in_buttons.dart';
import '../../widgets/sign_in/sign_up_link_row.dart';

/// Sign In Screen - Presentation Layer
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _rememberMe = false;
  late final AuthCubitV2 _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return SignInValidator.isFormValid(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
  }

  void _handleSignIn() {
    final errors = SignInValidator.validateForm(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );

    if (errors['email'] != null) {
      _showError(errors['email']!);
      return;
    }

    if (errors['password'] != null) {
      _showError(errors['password']!);
      return;
    }

    _authCubit.signIn(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AuthStrings.signInTitle,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.dark),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubitV2, AuthState>(
            listenWhen: (previous, current) =>
                current is AuthSuccessState ||
                current is AuthErrorState,
            listener: (context, state) {
              if (state is AuthSuccessState && state.action == 'sign_in') {
                _showSuccess(AuthStrings.successSignIn);
                // Navigate to home
                // context.go('/home');
              } else if (state is AuthErrorState) {
                _showError(state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<AuthCubitV2, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  _buildTitle(context),
                  SizedBox(height: 32.h),
                  AuthTextField(
                    label: AuthStrings.emailLabel,
                    hint: AuthStrings.emailPlaceholder,
                    controller: _emailCtrl,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: 20.h),
                  AuthTextField(
                    label: AuthStrings.passwordLabel,
                    hint: AuthStrings.passwordPlaceholder,
                    controller: _passwordCtrl,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: 16.h),
                  RememberForgotRow(
                    rememberMe: _rememberMe,
                    onRememberChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    onForgotTap: () {
                      context.push('/forgot_password');
                    },
                  ),
                  SizedBox(height: 32.h),
                  AuthPrimaryButton(
                    label: AuthStrings.login,
                    isLoading: isLoading,
                    isEnabled: _isFormValid(),
                    onPressed: _handleSignIn,
                  ),
                  SizedBox(height: 24.h),
                  const AuthOrDivider(),
                  SizedBox(height: 24.h),
                  SocialSignInButtons(
                    onGoogleTap: () {
                      if (!isLoading) _authCubit.signInWithGoogle();
                    },
                    onAppleTap: () {
                      if (!isLoading) _authCubit.signInWithApple();
                    },
                  ),
                  SizedBox(height: 32.h),
                  SignUpLinkRow(
                    onTap: () {
                      context.push('/sign_up');
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AuthStrings.welcomeBackAlt,
      style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
