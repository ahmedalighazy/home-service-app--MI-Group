// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../logic/cubits/auth_cubit.dart';
import '../../logic/states/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();

  bool _hasInput = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();

    _phoneController.addListener(() {
      final has = _phoneController.text.trim().isNotEmpty;
      if (has != _hasInput) setState(() => _hasInput = has);
    });
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }
  void _onSendCode(BuildContext context) {
    if (!_hasInput) return;
    final phone = _phoneController.text.trim();
    _phoneFocus.unfocus();
    context.read<AuthCubit>().loginWithPhone('+974$phone');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is OtpSent) {
            Navigator.of(context).pushNamed(
              AppRoutes.otp,
              arguments: '+974${_phoneController.text.trim()}',
            );
          } else if (state is AuthError) {
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
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              MediaQuery.of(context).padding.bottom,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 48.h),

                              // ── Title ───────────────────────────────────
                              Text(
                                AppStrings.welcomeBack,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppColors.dark,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 32.h),

                              // ── Phone Field ─────────────────────────────
                              _PhoneInputField(
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                              ),

                              SizedBox(height: 16.h),

                              // ── Send Code Button ────────────────────────
                              _SendCodeButton(
                                isLoading: isLoading,
                                isEnabled: _hasInput,
                                onPressed: () => _onSendCode(context),
                              ),

                        SizedBox(height: 12.h),

                        // ── Verification info ───────────────────────
                        Text(
                          AppStrings.verificationMethodInfo,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppColors.gray,
                            fontSize: 12.sp,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // ── Or Divider ──────────────────────────────
                        _OrDivider(),

                        SizedBox(height: 24.h),

                        // ── Google Button ───────────────────────────
                        _SocialLoginButton(
                          svgOrIconWidget: _GoogleIcon(),
                          label: AppStrings.signUpWithGoogle,
                          onPressed: () {},
                        ),

                        SizedBox(height: 12.h),

                        // ── Apple Button ────────────────────────────
                        _SocialLoginButton(
                          svgOrIconWidget: Icon(
                            Icons.apple,
                            size: 24.sp,
                            color: AppColors.primaryText,
                          ),
                          label: AppStrings.signUpWithApple,
                          onPressed: () {},
                        ),

                        SizedBox(height: 24.h),

                        // ── Continue as Guest ───────────────────────
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.home),
                            child: Text(
                              AppStrings.continueAsGuest,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.greenPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.greenPrimary,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // ── Already have account ────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(AppRoutes.emailLogin),
                              child: Text(
                                AppStrings.login,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppColors.greenPrimary,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '  ${AppStrings.alreadyHaveAccount}',
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.secondaryText,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // ── Terms ───────────────────────────────────
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            AppStrings.termsAndPrivacy,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ibmPlexSansArabic(
                              color: AppColors.gray,
                              fontSize: 11.sp,
                              height: 1.6,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const _PhoneInputField({required this.controller, required this.focusNode});

  @override
  State<_PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<_PhoneInputField> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => _isFocused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: _isFocused ? AppColors.greenPrimary : AppColors.borderInputs,
          width: _isFocused ? 1.5 : 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.greenPrimary.withOpacity(0.10),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Row(
        // In RTL context: first child = rightmost = country code
        // second child = leftmost = phone number input
        children: [
          // ── Country code (RIGHT side in RTL) ─────────
          Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F8FA),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(29.r),
                bottomRight: Radius.circular(29.r),
              ),
              border: Border(
                left: BorderSide(
                  color: _isFocused
                      ? AppColors.greenPrimary.withOpacity(0.3)
                      : AppColors.borderInputs,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🇶🇦', style: TextStyle(fontSize: 20.sp)),
                SizedBox(width: 6.w),
                Text(
                  '+974',
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.dark,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // ── Number input (LEFT side in RTL) ──────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                ],
                style: GoogleFonts.ibmPlexSansArabic(
                  color: AppColors.primaryText,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.phonePlaceholder,
                  hintStyle: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.placeholder,
                    fontSize: 14.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _SendCodeButton extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onPressed;

  const _SendCodeButton({
    required this.isLoading,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled && !isLoading ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: isEnabled
              ? const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFF0A434E),
                    Color(0xFF189AB4),
                  ],
                )
              : null,
          color: isEnabled ? null : AppColors.bgDisabled,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppColors.greenPrimary.withOpacity(0.3),
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
                    color: AppColors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  AppStrings.sendCode,
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: isEnabled
                        ? AppColors.white
                        : AppColors.disabledText,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Or Divider
// ─────────────────────────────────────────────────────────────
class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.borderInputs, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            AppStrings.orUsing,
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.gray,
              fontSize: 13.sp,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.borderInputs, thickness: 1)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Social Login Button
// ─────────────────────────────────────────────────────────────
class _SocialLoginButton extends StatefulWidget {
  final Widget svgOrIconWidget;
  final String label;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.svgOrIconWidget,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<_SocialLoginButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 52.h,
        decoration: BoxDecoration(
          color: _pressed ? const Color(0xFFF8FAFC) : AppColors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.borderInputs),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text first (RTL = text on right, icon on left visually)
            Text(
              widget.label,
              style: GoogleFonts.ibmPlexSansArabic(
                color: AppColors.primaryText,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 10.w),
            widget.svgOrIconWidget,
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Google "G" Icon (colored)
// ─────────────────────────────────────────────────────────────
class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.w,
      height: 22.w,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw colored segments as simple circle with letter G
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, bgPaint);

    // Simplified: draw 4-color ring
    final colors = [
      const Color(0xFF4285F4), // blue
      const Color(0xFF34A853), // green
      const Color(0xFFFBBC05), // yellow
      const Color(0xFFEA4335), // red
    ];
    final sweepAngle = 3.14159 * 2 / 4;
    for (int i = 0; i < 4; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.72),
        i * sweepAngle - 3.14159 / 2,
        sweepAngle * 0.85,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
