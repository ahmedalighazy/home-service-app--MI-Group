import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../logic/cubits/auth_cubit.dart';
import '../../logic/states/auth_state.dart';
import '../../presentation/widgets/auth_back_button.dart';
import '../../presentation/widgets/otp_confirm_button.dart';
import '../../presentation/widgets/otp_input_row.dart';

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

  OtpFieldState _fieldState = OtpFieldState.idle;
  int _secondsLeft = _totalSeconds;
  bool _canResend = false;
  Timer? _timer;

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
      if (_fieldState == OtpFieldState.error) {
        setState(() => _fieldState = OtpFieldState.idle);
      }
    });

    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
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
      if (!mounted) { t.cancel(); return; }
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
      _fieldState = OtpFieldState.idle;
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
        listener: _handleState,
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

                            // ── Back button ──────────────────────────
                            Align(
                              alignment: Alignment.centerRight,
                              child: AuthBackButton(
                                onTap: () => Navigator.pop(context),
                              ),
                            ),

                            SizedBox(height: 40.h),

                            // ── Title ────────────────────────────────
                            Text(
                              AppStrings.confirmCode,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.dark,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            Text(
                              AppStrings.enterVerificationCode,
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

                            // ── OTP circles ──────────────────────────
                            OtpInputRow(
                              digits: _digits,
                              length: _length,
                              fieldState: _fieldState,
                              shakeAnimation: _shakeAnim,
                              onTap: () => _focusNode.requestFocus(),
                            ),

                            SizedBox(height: 20.h),

                            // ── Countdown timer ──────────────────────
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
                                  : const SizedBox.shrink(
                                      key: ValueKey('empty')),
                            ),

                            SizedBox(height: 10.h),

                            // ── Resend row ───────────────────────────
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _canResend
                                      ? () => _onResend(context)
                                      : null,
                                  child: Text(
                                    AppStrings.resendCodeLink,
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
                                  ' ${AppStrings.resendCodePrompt}',
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.gray,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 32.h),

                            // ── Inline error message ─────────────────
                            if (_fieldState == OtpFieldState.error)
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

                            // ── Confirm button ───────────────────────
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _digits.length == _length
                                  ? OtpConfirmButton(
                                      key: const ValueKey('btn'),
                                      label: AppStrings.confirm,
                                      isLoading: isLoading,
                                      isSuccess:
                                          _fieldState == OtpFieldState.success,
                                      isEnabled:
                                          _fieldState != OtpFieldState.error,
                                      onPressed: () => _onConfirm(context),
                                    )
                                  : SizedBox(
                                      height: 54.h,
                                      key: const ValueKey('empty')),
                            ),

                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),

                    // ── Hidden text input ────────────────────────────
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          style: const TextStyle(
                              color: Colors.transparent, fontSize: 0),
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

  void _handleState(BuildContext context, AuthState state) {
    if (state is OtpVerified) {
      setState(() => _fieldState = OtpFieldState.success);
      final navigator = Navigator.of(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          navigator.pushReplacementNamed(
            AppRoutes.completeProfile,
            arguments: widget.phoneNumber,
          );
        }
      });
    } else if (state is OtpError) {
      setState(() => _fieldState = OtpFieldState.error);
      _shakeCtrl.forward(from: 0.0);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
    } else if (state is AuthError) {
      setState(() => _fieldState = OtpFieldState.error);
      _shakeCtrl.forward(from: 0.0);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
    } else if (state is OtpSent) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: const Text('تم إعادة إرسال رمز التحقق بنجاح'),
          backgroundColor: AppColors.greenPrimary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
    }
  }
}



