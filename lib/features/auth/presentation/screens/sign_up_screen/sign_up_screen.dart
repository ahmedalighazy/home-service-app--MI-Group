import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../logic/validators/sign_up_validator.dart';
import '../../cubits/auth_cubit_v2.dart';
import '../../states/auth_state.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

// New UI Widgets
import '../../widgets/auth_primary_button.dart';
import '../../widgets/auth_or_divider.dart';
import '../../widgets/sign_up/social_sign_up_buttons.dart';
import '../../widgets/sign_up/sign_in_row.dart';
import '../../widgets/sign_up/terms_and_privacy.dart';

/// Sign Up Screen - Presentation Layer
/// 
/// Handles user registration with phone verification
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneCtrl = TextEditingController();
  late final AuthCubitV2 _authCubit;
  bool _phoneError = false;
  bool _isFocused = false;
  static const _countryCode = '+974';

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _handleSendCode() {
    final error = SignUpValidator.validatePhone(_phoneCtrl.text);
    if (error != null) {
      setState(() => _phoneError = true);
      _showError(error);
      return;
    }

    setState(() => _phoneError = false);
    FocusScope.of(context).unfocus();
    _authCubit.sendOtp(
      phoneNumber: '$_countryCode${_phoneCtrl.text.trim()}',
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
          AuthStrings.signUpTitle,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.dark),
      ),
      body: BlocListener<AuthCubitV2, AuthState>(
        listenWhen: (previous, current) =>
            current is OtpSentState || current is OtpErrorState,
        listener: (context, state) {
          if (state is OtpSentState) {
            _showSuccess(AuthStrings.successOtpSent);
            context.push('/otp', extra: state.phoneNumber);
          } else if (state is OtpErrorState) {
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
                    AuthStrings.welcomeBack,
                    style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AuthStrings.signUpOtpMessage,
                    style: AppText.ibmDescription14(color: AppColors.secondaryText),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  _buildPhoneField(),
                  if (_phoneError) ...[
                    SizedBox(height: 6.h),
                    Text(
                      SignUpValidator.validatePhone(_phoneCtrl.text) ??
                          AuthStrings.phoneRequired,
                      style: AppText.ibmError12(),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  AuthPrimaryButton(
                    label: AuthStrings.sendCode,
                    isLoading: isLoading,
                    isEnabled: _phoneCtrl.text.isNotEmpty,
                    onPressed: _handleSendCode,
                  ),
                  SizedBox(height: 24.h),
                  const AuthOrDivider(),
                  SizedBox(height: 24.h),
                  SocialSignUpButtons(
                    onGoogleTap: () {
                      if (!isLoading) _authCubit.signInWithGoogle();
                    },
                    onAppleTap: () {
                      if (!isLoading) _authCubit.signInWithApple();
                    },
                  ),
                  SizedBox(height: 32.h),
                  SignInRow(
                    onTap: () {
                      context.push('/sign_in');
                    },
                  ),
                  SizedBox(height: 16.h),
                  TermsAndPrivacy(
                    onTermsTap: () {},
                    onPrivacyTap: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    final borderColor = _phoneError
        ? AppColors.errorRed
        : _isFocused
            ? AppColors.greenPrimary
            : AppColors.borderInputs;
    final double borderWidth = _isFocused ? 1.5 : 1.0;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          AuthStrings.phoneLabel,
          style: AppText.ibmFieldLabel14(
            color: _phoneError ? AppColors.errorRed : AppColors.dark,
          ),
        ),
        SizedBox(height: 8.h),
        Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: borderWidth),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppColors.greenPrimary.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Text(AuthStrings.flagQatar, style: TextStyle(fontSize: 18.sp)),
                SizedBox(width: 8.w),
                Text(
                  _countryCode,
                  style: AppText.ibmDescription14(color: AppColors.primaryText).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 1,
                  height: 24.h,
                  color: AppColors.borderInputs,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    style: AppText.ibmDescription14(color: AppColors.primaryText),
                    decoration: InputDecoration(
                      hintText: AuthStrings.phonePlaceholder,
                      hintStyle: AppText.ibmPlaceholder14(),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onChanged: (_) {
                      if (_phoneError) setState(() => _phoneError = false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
