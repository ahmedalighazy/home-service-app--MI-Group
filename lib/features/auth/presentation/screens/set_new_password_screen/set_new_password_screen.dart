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
import '../../widgets/forget_password/password_success_dialog.dart';

/// Set New Password Screen - Presentation Layer
class SetNewPasswordScreen extends StatefulWidget {
  final String email;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  late final AuthCubitV2 _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
  }

  @override
  void dispose() {
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return SignInValidator.isPasswordValid(_newPasswordCtrl.text.trim()) &&
        _newPasswordCtrl.text.trim() == _confirmPasswordCtrl.text.trim();
  }

  void _handleResetPassword() {
    final newPassword = _newPasswordCtrl.text.trim();
    final confirmPassword = _confirmPasswordCtrl.text.trim();

    // Validate new password
    final passwordError = SignInValidator.validatePassword(newPassword);
    if (passwordError != null) {
      _showError(passwordError);
      return;
    }

    // Check if passwords match
    if (newPassword != confirmPassword) {
      _showError(AuthStrings.passwordMismatch);
      return;
    }

    _authCubit.resetPassword(
      email: widget.email,
      newPassword: newPassword,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AuthStrings.setNewPasswordTitle,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.dark),
      ),
      body: BlocListener<AuthCubitV2, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthAuthenticated ||
            current is PasswordResetErrorState,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            showPasswordSuccessDialog(context, () {
              context.go('/sign_in');
            });
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
                    AuthStrings.setNewPasswordTitle,
                    style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AuthStrings.setNewPasswordDescription,
                    style: AppText.ibmDescription14(color: AppColors.secondaryText),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  AuthTextField(
                    label: AuthStrings.newPasswordLabel,
                    hint: AuthStrings.newPasswordPlaceholder,
                    controller: _newPasswordCtrl,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: 16.h),
                  AuthTextField(
                    label: AuthStrings.confirmPasswordLabel,
                    hint: AuthStrings.confirmPasswordPlaceholder,
                    controller: _confirmPasswordCtrl,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: 32.h),
                  AuthPrimaryButton(
                    label: AuthStrings.updatePassword,
                    isLoading: isLoading,
                    isEnabled: _isFormValid(),
                    onPressed: _handleResetPassword,
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
