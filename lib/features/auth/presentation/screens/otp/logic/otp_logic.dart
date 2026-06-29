import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/utils/l10n/localization_service.dart';

enum OtpFieldState { idle, error, success }

class OtpScreenLogic {
  final String email;
  final TickerProvider vsync;
  final VoidCallback onStateChanged;

  static const int length = 6;
  static const int totalSeconds = 59;

  final TextEditingController ctrl = TextEditingController();
  final FocusNode focusNode = FocusNode();

  OtpFieldState fieldState = OtpFieldState.idle;
  int secondsLeft = totalSeconds;
  bool canResend = false;
  Timer? timer;

  late AnimationController shakeCtrl;
  late Animation<double> shakeAnim;

  OtpScreenLogic({
    required this.email,
    required this.vsync,
    required this.onStateChanged,
  }) {
    _init();
  }

  void _init() {
    shakeCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: shakeCtrl, curve: Curves.easeInOut));

    ctrl.addListener(() {
      if (fieldState == OtpFieldState.error) {
        fieldState = OtpFieldState.idle;
        onStateChanged();
      }
    });

    startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft = totalSeconds;
    canResend = false;
    onStateChanged();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft > 0) {
        secondsLeft--;
        onStateChanged();
      } else {
        canResend = true;
        t.cancel();
        onStateChanged();
      }
    });
  }

  void onConfirm(BuildContext context) {
    if (ctrl.text.length < length) return;
    focusNode.unfocus();
    getIt<AuthCubit>().verifyOtp(phoneNumber: email, otp: ctrl.text);
  }

  void onResend(BuildContext context) {
    if (!canResend) return;
    ctrl.clear();
    fieldState = OtpFieldState.idle;
    onStateChanged();
    getIt<AuthCubit>().loginWithPhone(email);
    startTimer();
    focusNode.requestFocus();
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is AuthSuccessState && state.action == 'otp_verified') {
      fieldState = OtpFieldState.success;
      onStateChanged();
      final router = GoRouter.of(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        router.go(AppRouter.completeProfile, extra: email);
      });
    } else if (state is OtpErrorState || state is AuthErrorState) {
      fieldState = OtpFieldState.error;
      onStateChanged();
      shakeCtrl.forward(from: 0.0);
      final msg = state is OtpErrorState
          ? state.message
          : (state as AuthErrorState).message;
      _showSnackBar(context, msg, AppColors.errorRed);
    } else if (state is OtpSentState) {
      _showSnackBar(context, LocalizationService.instance.translate('otpResendSuccess'), AppColors.greenPrimary);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
  }

  void dispose() {
    timer?.cancel();
    shakeCtrl.dispose();
    ctrl.dispose();
    focusNode.dispose();
  }
}
