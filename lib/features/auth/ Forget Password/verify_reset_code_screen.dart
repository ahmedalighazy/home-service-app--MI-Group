import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import '../../../core/di/injection.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String email;
  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen>
    with SingleTickerProviderStateMixin {
  static const int _length = 6;

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _hasError = false;
  bool _isSuccess = false;

  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));

    _ctrl.addListener(() {
      final raw = _ctrl.text.replaceAll(RegExp(r'\D'), '');
      final capped = raw.length > _length ? raw.substring(0, _length) : raw;
      if (_ctrl.text != capped) {
        _ctrl.value = _ctrl.value.copyWith(
          text: capped,
          selection: TextSelection.collapsed(offset: capped.length),
        );
        return;
      }
      if (_hasError) setState(() => _hasError = false);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _digits => _ctrl.text;

  void _onVerify(BuildContext context) {
    if (_digits.length < _length) return;
    _focusNode.unfocus();
    context.read<AuthCubit>().verifyResetCode(widget.email, _digits);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetCodeVerified) {
            setState(() {
              _isSuccess = true;
            });
            final navigator = Navigator.of(context);
            Future.delayed(const Duration(milliseconds: 400), () {
              if (mounted) {
                navigator.pushReplacementNamed(
                  AppRoutes.setNewPassword,
                  arguments: {
                    'email': widget.email,
                    'code': _digits,
                  },
                );
              }
            });
          } else if (state is AuthError) {
            setState(() {
              _hasError = true;
            });
            _shakeCtrl.forward(from: 0.0);
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
            resizeToAvoidBottomInset: true,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),

                            // ── Back button ────────────────────────────
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

                            // ── Title ──────────────────────────────────
                            Text(
                              'تحقق من بريدك',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.dark,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            Text(
                              'أدخل رمز التحقق المكون من 6 أرقام المرسل إلى',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.secondaryText,
                                fontSize: 13.sp,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 4.h),

                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                widget.email,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppColors.greenPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: 44.h),

                            // ── OTP circles ────────────────────────────
                            _buildOtpRow(),

                            SizedBox(height: 32.h),

                            if (_hasError)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Text(
                                  'الرمز غير صحيح، يرجى المحاولة مرة أخرى',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.errorRed,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),

                            // ── Confirm button ─────────────────────────
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _digits.length == _length
                                  ? _buildConfirmButton(
                                key: const ValueKey('btn'),
                                isLoading: isLoading,
                                context: context,
                              )
                                  : SizedBox(
                                height: 54.h,
                                key: const ValueKey('empty'),
                              ),
                            ),

                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),

                    // ── Hidden keyboard capture ────────────────────────
                    SizedBox(
                      height: 0,
                      child: TextField(
                        controller: _ctrl,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: _length,
                        showCursor: false,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        style: const TextStyle(color: Colors.transparent, fontSize: 1),
                        cursorColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOtpRow() {
    return AnimatedBuilder(
      animation: _shakeAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_hasError ? _shakeAnim.value : 0, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_length, (i) {
            final hasDigit = i < _digits.length;
            final isCurrent = i == _digits.length;

            Color borderColor;
            Color fillColor;
            Color textColor;

            if (_hasError && hasDigit) {
              borderColor = AppColors.errorRed;
              fillColor = AppColors.bgError;
              textColor = AppColors.errorRed;
            } else if (_isSuccess && hasDigit) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.light;
              textColor = AppColors.greenPrimary;
            } else if (hasDigit || isCurrent) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.white;
              textColor = AppColors.primaryText;
            } else {
              borderColor = AppColors.borderInputs;
              fillColor = AppColors.white;
              textColor = AppColors.primaryText;
            }

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fillColor,
                border: Border.all(color: borderColor, width: 1.5),
                boxShadow: (hasDigit || isCurrent)
                    ? [
                  BoxShadow(
                    color: (_hasError
                        ? AppColors.errorRed
                        : AppColors.greenPrimary)
                        .withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : [],
              ),
              child: Center(
                child: hasDigit
                    ? Text(
                  _digits[i],
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: textColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    : isCurrent
                    ? _BlinkingCursor()
                    : null,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildConfirmButton({
    Key? key,
    required bool isLoading,
    required BuildContext context,
  }) {
    return GestureDetector(
      key: key,
      onTap: isLoading ? null : () => _onVerify(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFF0A434E), Color(0xFF189AB4)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF189AB4).withValues(alpha: 0.3),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
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
              : _isSuccess
              ? Icon(Icons.check_rounded, color: Colors.white, size: 24.sp)
              : Text(
            'تأكيد الرمز',
            style: GoogleFonts.ibmPlexSansArabic(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 1.5.w,
        height: 18.h,
        color: AppColors.greenPrimary,
      ),
    );
  }
}