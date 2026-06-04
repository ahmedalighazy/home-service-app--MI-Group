import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/forget_password/forget_email_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    final email = _emailCtrl.text.trim();
    return email.isNotEmpty && email.contains('@') && email.contains('.');
  }

  void _onSend(BuildContext context) {
    if (!_isValid) return;
    context.read<AuthCubit>().sendResetCode(_emailCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetCodeSent) {
            Navigator.of(context).pushNamed(
              AppRoutes.verifyResetCode,
              arguments: state.email,
            );
          } else if (state is AuthError) {
            setState(() => _hasError = true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';

          return Scaffold(
            backgroundColor: AppColors.white,
            body: Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16.h),

                                // ── Back button ──────────────────────────────────
                                Align(
                                  alignment: isArabic
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: AuthBackButton(
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),

                                SizedBox(height: 40.h),

                                // ── Title ────────────────────────────────────────
                                Text(
                                  AppStrings.forgotPassword,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.dark,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                Text(
                                  isArabic
                                      ? 'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور'
                                      : 'Enter your email and we\'ll send you a verification code to reset your password',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.secondaryText,
                                    fontSize: 13.sp,
                                    height: 1.6,
                                  ),
                                ),

                                SizedBox(height: 44.h),

                                // ── Email label ──────────────────────────────────
                                Text(
                                  AppStrings.emailLabel,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.primaryText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                // ── Email field ──────────────────────────────────
                                ForgetEmailField(
                                  controller: _emailCtrl,
                                  hasError: _hasError,
                                  onChanged: (_) =>
                                      setState(() => _hasError = false),
                                ),

                                if (_hasError) ...[
                                  SizedBox(height: 6.h),
                                  Text(
                                    isArabic
                                        ? 'يرجى إدخال بريد إلكتروني صحيح'
                                        : 'Please enter a valid email address',
                                    style: GoogleFonts.ibmPlexSansArabic(
                                      color: AppColors.errorRed,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],

                                const Spacer(),
                                SizedBox(height: 24.h),

                                // ── Send button ──────────────────────────────────
                                GestureDetector(
                                  onTap: _isValid && !isLoading
                                      ? () => _onSend(context)
                                      : null,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: double.infinity,
                                    height: 56.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50.r),
                                      gradient: _isValid
                                          ? const LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xFF4DC8C8),
                                                Color(0xFF0D5C5C)
                                              ],
                                            )
                                          : null,
                                      color: _isValid
                                          ? null
                                          : AppColors.bgDisabled,
                                      boxShadow: _isValid
                                          ? [
                                              BoxShadow(
                                                color: const Color(0xFF1E7B7B)
                                                    .withValues(alpha: 0.35),
                                                blurRadius: 14,
                                                offset: const Offset(0, 5),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: isLoading
                                          ? SizedBox(
                                              width: 22.w,
                                              height: 22.w,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : Text(
                                              isArabic
                                                  ? 'أرسل الكود'
                                                  : 'Send Code',
                                              style: GoogleFonts.ibmPlexSansArabic(
                                                color: _isValid
                                                    ? Colors.white
                                                    : AppColors.disabledText,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 24.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
