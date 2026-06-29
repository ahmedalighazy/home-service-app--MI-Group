import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/routes/app_routes.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

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
    context.read<AuthCubit>().resetState();

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
        setState(() {
          _fieldState = OtpFieldState.idle;
        });
      } else {
        setState(() {});
      }
    });

    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsLeft = _totalSeconds;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        t.cancel();
      }
    });
  }

  void _onConfirm() {
    if (_ctrl.text.length < _length) return;
    _focusNode.unfocus();
    context.read<AuthCubit>().verifyOtp(phoneNumber: widget.email, otp: _ctrl.text);
  }

  void _onResend() {
    if (!_canResend) return;
    _ctrl.clear();
    setState(() {
      _fieldState = OtpFieldState.idle;
    });
    context.read<AuthCubit>().loginWithPhone(widget.email);
    _startTimer();
    _focusNode.requestFocus();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeCtrl.dispose();
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerifiedState) {
          setState(() {
            _fieldState = OtpFieldState.success;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              context.go(AppRouter.completeProfile, extra: widget.email);
            }
          });
        } else if (state is OtpErrorState || state is AuthErrorState) {
          setState(() {
            _fieldState = OtpFieldState.error;
          });
          _shakeCtrl.forward(from: 0.0);
          final msg = state is OtpErrorState
              ? state.message
              : (state as AuthErrorState).message;
          _showSnackBar(msg, AppColors.errorRed);
        } else if (state is OtpSentState) {
          _showSnackBar(
            LocalizationService.instance.translate('otpResendSuccess'),
            AppColors.greenPrimary,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomBackArrowButton(),
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          context.tr('confirmCode'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          context.tr('enterVerificationCode'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 13.sp,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            widget.email,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.greenPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 48.h),
                        GestureDetector(
                          onTap: () => _focusNode.requestFocus(),
                          child: OtpInputRow(
                            digits: _ctrl.text,
                            length: _length,
                            fieldState: _fieldState,
                            shakeAnimation: _shakeAnim,
                            onTap: () => _focusNode.requestFocus(),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: !_canResend
                              ? Text(
                                  '0:${_secondsLeft.toString().padLeft(2, '0')}',
                                  key: const ValueKey('timer'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                              onTap: _canResend ? _onResend : null,
                              child: Text(
                                context.tr('resendCodeLink'),
                                style: TextStyle(
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
                            Flexible(
                              child: Text(
                                ' ${context.tr('resendCodePrompt')}',
                                style: TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 13.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        if (_fieldState == OtpFieldState.error)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              context.tr('otpCodeError'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.errorRed,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 24.w,
                  right: 24.w,
                  bottom: 24.h,
                  child: OtpConfirmButton(
                    label: context.tr('confirm'),
                    isLoading: isLoading,
                    isSuccess: _fieldState == OtpFieldState.success,
                    isEnabled:
                        _ctrl.text.length == _length &&
                        _fieldState != OtpFieldState.error,
                    onPressed: _ctrl.text.length == _length ? _onConfirm : () {},
                  ),
                ),
                Positioned(
                  left: -9999,
                  top: -9999,
                  child: SizedBox(
                    width: 1,
                    height: 1,
                    child: TextField(
                      controller: _ctrl,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      maxLength: _length,
                      showCursor: false,
                      enableInteractiveSelection: false,
                      stylusHandwritingEnabled: false,
                      selectionControls: EmptyTextSelectionControls(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      style: const TextStyle(
                        color: Colors.transparent,
                        fontSize: 1,
                      ),
                      cursorColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
