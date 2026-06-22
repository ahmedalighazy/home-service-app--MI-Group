import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';

import '../../../../../../core/utils/l10n/localization_service.dart';

class VerificationController extends ChangeNotifier {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  bool isButtonEnabled = false;

  Timer? _timer;
  int secondsRemaining = 59;
  bool isTimerActive = true;

  VerificationController() {
    for (var controller in controllers) {
      controller.addListener(_checkCompletion);
    }
    startTimer();
  }

  // ── Timer ──────────────────────────────────────────────────────────────────

  void startTimer() {
    _timer?.cancel();
    secondsRemaining = 59;
    isTimerActive = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        isTimerActive = false;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  String get formattedTime {
    final minutes = (secondsRemaining ~/ 60).toString();
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // ── OTP input ──────────────────────────────────────────────────────────────

  void _checkCompletion() {
    final completed =
        controllers.every((controller) => controller.text.isNotEmpty);
    if (completed != isButtonEnabled) {
      isButtonEnabled = completed;
      notifyListeners();
    }
  }

  String get otpCode => controllers.map((c) => c.text).join();

  void handleOtpChange(String value, int index) {
    if (value.length == 1 && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  /// إعادة إرسال الكود — يستدعي الـ API فعلاً ويعيد العداد
  void resendCode(BuildContext context, String email) {
    if (isTimerActive) return;
    getIt<AuthCubit>().sendResetCode(email);
    startTimer();
  }

  /// تأكيد الكود — يستدعي verifyResetCode والـ navigation تتم عبر handleState
  void onConfirm(BuildContext context, String email) {
    if (!isButtonEnabled) return;
    getIt<AuthCubit>().verifyResetCode(email, otpCode);
  }

  // ── State handler ──────────────────────────────────────────────────────────

  void handleState(BuildContext context, AuthState state, String email) {
    if (state is AuthSuccessState && state.action == 'reset_code_verified') {
      GoRouter.of(context).push(
        AppRouter.setNewPassword,
        extra: <String, dynamic>{'email': email, 'code': otpCode},
      );
    } else if (state is ResetCodeError) {
      _showSnackBar(context, state.message, const Color(0xFFE05C5C));
    } else if (state is AuthErrorState) {
      _showSnackBar(context, state.message, const Color(0xFFE05C5C));
    } else if (state is ResetCodeSentState) {
      _showSnackBar(context, LocalizationService.instance.translate('resendCodeSuccess'), const Color(0xFF1B85A6));
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }
}
