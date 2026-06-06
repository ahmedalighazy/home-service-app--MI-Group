import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_or_divider.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up/complete_registration_link.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up/sign_in_row.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up/social_sign_up_buttons.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneCtrl = TextEditingController();
  final _phoneFocusNode = FocusNode();
  late final AuthCubit _authCubit;
  bool _phoneError = false;
  static const _countryCode = '+974';

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  bool _isPhoneValid() {
    final cleaned = _phoneCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 8) return false;
    return cleaned[0].compareTo('3') >= 0 && cleaned[0].compareTo('9') <= 0;
  }

  void _handleSendCode(BuildContext context) {
    if (!_isPhoneValid()) {
      setState(() => _phoneError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.phoneRequired),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    setState(() => _phoneError = false);
    FocusScope.of(context).unfocus();
    _authCubit.sendOtp(
          phoneNumber: '$_countryCode${_phoneCtrl.text.trim()}',
        );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppStrings.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider.value(
          value: _authCubit,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is OtpSent) {
                Navigator.of(context).pushNamed(
                  AppRoutes.otp,
                  arguments: '$_countryCode${_phoneCtrl.text.trim()}',
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.errorRed,
                  ),
                );
              } else if (state is GoogleSignInSuccess ||
                  state is AppleSignInSuccess) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 12.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40.r),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                AppStrings.welcomeBack,
                                style: AppText.ibmHeading22(
                                  color: AppColors.primaryText,
                                ),
                              ),
                              SizedBox(height: 32.h),
                              _buildPhoneField(),
                              if (_phoneError) ...[
                                SizedBox(height: 6.h),
                                Text(
                                  AppStrings.phoneRequired,
                                  style: AppText.ibmError12(),
                                ),
                              ],
                              SizedBox(height: 24.h),
                              AuthPrimaryButton(
                                label: AppStrings.sendCode,
                                isLoading: state is AuthLoading,
                                isEnabled: _isPhoneValid(),
                                onPressed: () => _handleSendCode(context),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                AppStrings.signUpOtpMessage,
                                textAlign: TextAlign.center,
                                style: AppText.ibmCaption11(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              SizedBox(height: 28.h),
                              const AuthOrDivider(),
                              SizedBox(height: 24.h),
                              SocialSignUpButtons(
                                onGoogleTap: () =>
                                    _authCubit.signInWithGoogle(),
                                onAppleTap: () =>
                                    _authCubit.signInWithApple(),
                              ),
                              SizedBox(height: 28.h),
                              CompleteRegistrationLink(
                                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
                              ),
                              SizedBox(height: 28.h),
                              SignInRow(
                                onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    final borderColor =
        _phoneError ? AppColors.errorRed : AppColors.borderFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🇶🇦', style: TextStyle(fontSize: 18.sp)),
              SizedBox(width: 8.w),
              Text(
                _countryCode,
                style: AppText.ibmDescription14(color: AppColors.primaryText)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Container(
            width: 1,
            height: 22.h,
            color: AppColors.borderInputs,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: TextField(
              controller: _phoneCtrl,
              focusNode: _phoneFocusNode,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: AppText.ibmDescription14(color: AppColors.primaryText)
                  .copyWith(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: AppStrings.phonePlaceholder,
                hintStyle: AppText.ibmPlaceholder14(),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (_) {
                if (_phoneError) setState(() => _phoneError = false);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
