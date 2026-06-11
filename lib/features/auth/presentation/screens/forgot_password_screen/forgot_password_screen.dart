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

/// Forgot Password Screen - Presentation Layer
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  late final AuthCubitV2 _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return SignInValidator.isEmailValid(_emailCtrl.text.trim());
  }

  void _handleSendResetCode() {
    final error = SignInValidator.validateEmail(_emailCtrl.text.trim());

    if (error != null) {
      _showError(error);
      return;
    }

    _authCubit.requestPasswordReset(email: _emailCtrl.text.trim());
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
          AuthStrings.forgotPasswordTitle,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.dark),
      ),
      body: BlocListener<AuthCubitV2, AuthState>(
        listenWhen: (previous, current) =>
            current is ResetCodeSentState || current is PasswordResetErrorState,
        listener: (context, state) {
          if (state is ResetCodeSentState) {
            _showSuccess(AuthStrings.successResetCodeSent);
            context.push('/verify_reset_code', extra: state.email);
          } else if (state is PasswordResetErrorState) {
            _showError(state.message);
          }
        },
        child: BlocBuilder<AuthCubitV2, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    AuthStrings.forgotPasswordTitle,
                    style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AuthStrings.forgotPasswordDescription,
                    style: AppText.ibmDescription14(color: AppColors.secondaryText),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  AuthTextField(
                    label: AuthStrings.emailLabel,
                    hint: AuthStrings.emailPlaceholder,
                    controller: _emailCtrl,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: 32.h),
                  AuthPrimaryButton(
                    label: AuthStrings.sendResetCode,
                    isLoading: isLoading,
                    isEnabled: _isFormValid(),
                    onPressed: _handleSendResetCode,
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        AuthStrings.backToSignIn,
                        style: AppText.ibmLink13(color: AppColors.greenPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
