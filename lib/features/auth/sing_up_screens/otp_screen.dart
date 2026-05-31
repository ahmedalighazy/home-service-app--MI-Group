import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../logic/cubits/auth_cubit.dart';
import '../logic/states/auth_state.dart';

/// حالات واجهة الرمز المؤقت
enum _OtpState { idle, error, success }

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  static const int _length = 6;
  static const int _totalSeconds = 59;

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  _OtpState _state = _OtpState.idle;
  int _secondsLeft = _totalSeconds;
  bool _canResend = false;
  Timer? _timer;

  // تأثير الاهتزاز عند الخطأ
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
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));

    _ctrl.addListener(() {
      if (_state == _OtpState.error) {
        setState(() {
          _state = _OtpState.idle;
        });
      }
    });

    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeCtrl.dispose();
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsLeft = _totalSeconds;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _canResend = true;
          t.cancel();
        }
      });
    });
  }

  void _onConfirm(BuildContext context) {
    if (_ctrl.text.length < _length) return;
    _focusNode.unfocus();
    context.read<AuthCubit>().verifyOtp(widget.phoneNumber, _ctrl.text);
  }

  void _onResend(BuildContext context) {
    if (!_canResend) return;
    setState(() {
      _ctrl.clear();
      _state = _OtpState.idle;
    });
    context.read<AuthCubit>().loginWithPhone(widget.phoneNumber);
    _startTimer();
    _focusNode.requestFocus();
  }

  String get _digits => _ctrl.text;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            setState(() {
              _state = _OtpState.success;
            });
            final navigator = Navigator.of(context);
            Future.delayed(const Duration(milliseconds: 400), () {
              if (mounted) {
                navigator.pushReplacementNamed(
                  AppRoutes.completeProfile,
                  arguments: widget.phoneNumber,
                );
              }
            });
          } else if (state is AuthError) {
            setState(() {
              _state = _OtpState.error;
            });
            _shakeCtrl.forward(from: 0.0);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          } else if (state is OtpSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إعادة إرسال رمز التحقق بنجاح'),
                backgroundColor: AppColors.greenPrimary,
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: _BackButton(
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Text(
                              'تأكيد الرمز',
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
                                widget.phoneNumber,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppColors.greenPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 44.h),
                            _buildOtpRow(),
                            SizedBox(height: 20.h),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: !_canResend
                                  ? Text(
                                '0:${_secondsLeft.toString().padLeft(2, '0')}',
                                key: const ValueKey('timer'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ibmPlexSansArabic(
                                  color: AppColors.gray,
                                  fontSize: 14.sp,
                                ),
                              )
                                  : const SizedBox.shrink(key: ValueKey('empty')),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _canResend ? () => _onResend(context) : null,
                                  child: Text(
                                    'إعادة إرسال الكود',
                                    style: GoogleFonts.ibmPlexSansArabic(
                                      color: _canResend
                                          ? AppColors.greenPrimary
                                          : AppColors.placeholder,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      decoration: _canResend
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationColor: AppColors.greenPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' لم تتلقى الكود بعد؟',
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.gray,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.h),
                            if (_state == _OtpState.error)
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
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _digits.length == _length
                                  ? _ConfirmButton(
                                key: const ValueKey('btn'),
                                isLoading: isLoading,
                                isSuccess: _state == _OtpState.success,
                                onPressed: _state != _OtpState.error
                                    ? () => _onConfirm(context)
                                    : () {},
                              )
                                  : SizedBox(height: 54.h, key: const ValueKey('empty')),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),

                    // الحقل المخفي المحدث لاستقبال المدخلات بشكل آمن وثابت
                    SizedBox(
                      width: 1,
                      height: 1,
                      child: Opacity(
                        opacity: 0,
                        child: TextField(
                          controller: _ctrl,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          maxLength: _length,
                          showCursor: false,
                          enableInteractiveSelection: false,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          style: const TextStyle(color: Colors.transparent, fontSize: 0),
                          cursorColor: Colors.transparent,
                        ),
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
          offset: Offset(_state == _OtpState.error ? _shakeAnim.value : 0.0, 0.0),
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

            if (_state == _OtpState.error && hasDigit) {
              borderColor = AppColors.errorRed;
              fillColor = AppColors.bgError;
              textColor = AppColors.errorRed;
            } else if (_state == _OtpState.success && hasDigit) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.light;
              textColor = AppColors.greenPrimary;
            } else if (hasDigit) {
              borderColor = AppColors.greenPrimary;
              fillColor = AppColors.white;
              textColor = AppColors.primaryText;
            } else if (isCurrent) {
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
                    color: (_state == _OtpState.error
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

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final bool isLoading;
  final bool isSuccess;
  final VoidCallback onPressed;

  const _ConfirmButton({
    super.key,
    required this.isLoading,
    required this.isSuccess,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
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
              : isSuccess
              ? Icon(Icons.check_rounded, color: Colors.white, size: 24.sp)
              : Text(
            'تأكيد',
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