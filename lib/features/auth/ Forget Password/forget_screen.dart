import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import '../../../core/di/injection.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';

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

          return Scaffold(
            backgroundColor: AppColors.white,
            body: Directionality(
              textDirection: TextDirection.rtl,
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
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.borderInputs),
                                        color: AppColors.white,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15.sp,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 40.h),

                                // ── Title ────────────────────────────────────────
                                Text(
                                  'نسيت كلمة المرور؟',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.dark,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                Text(
                                  'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور',
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
                                  'البريد الإلكتروني',
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.primaryText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                // ── Email field ──────────────────────────────────
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: _hasError
                                          ? AppColors.errorRed
                                          : AppColors.borderInputs,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greenPrimary.withValues(alpha: 0.06),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: _emailCtrl,
                                    keyboardType: TextInputType.emailAddress,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    onChanged: (_) => setState(() => _hasError = false),
                                    style: GoogleFonts.ibmPlexSansArabic(
                                      color: AppColors.primaryText,
                                      fontSize: 14.sp,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'example@email.com',
                                      hintStyle: GoogleFonts.ibmPlexSansArabic(
                                        color: AppColors.placeholder,
                                        fontSize: 13.sp,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 14.h,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: AppColors.gray,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),

                                if (_hasError) ...[
                                  SizedBox(height: 6.h),
                                  Text(
                                    'يرجى إدخال بريد إلكتروني صحيح',
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
                                  onTap: _isValid && !isLoading ? () => _onSend(context) : null,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: double.infinity,
                                    height: 54.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      gradient: _isValid
                                          ? const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [Color(0xFF0A434E), Color(0xFF189AB4)],
                                      )
                                          : null,
                                      color: _isValid ? null : AppColors.bgDisabled,
                                      boxShadow: _isValid
                                          ? [
                                        BoxShadow(
                                          color: const Color(0xFF189AB4).withValues(alpha: 0.3),
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
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                          : Text(
                                        'إرسال رمز التحقق',
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
