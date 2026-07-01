import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/auth_repo.dart';
import '../../logic/otp_timer.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo authRepo;

  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial()) {
    newPasswordCtrl.addListener(_rebuild);
    confirmPasswordCtrl.addListener(_rebuild);
    resetCodeCtrl.addListener(_rebuild);
  }

  // ── Controllers ──
  final emailCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final resetCodeCtrl = TextEditingController();
  final resetFocusNode = FocusNode();

  // ── Email Verification Controllers (check_your_email) ──
  final emailVerificationControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final emailVerificationFocusNodes = List.generate(6, (_) => FocusNode());

  // ── Timer State ──
  OtpTimer? emailVerificationTimer;
  int emailVerificationSecondsLeft = 59;
  bool emailVerificationTimerActive = true;
  bool emailVerificationButtonEnabled = false;

  void _rebuild() {
    if (!isClosed) emit(ForgotPasswordInitial());
  }

  String get emailVerificationOtpCode =>
      emailVerificationControllers.map((c) => c.text).join();

  bool isNewPasswordEmpty() =>
      newPasswordCtrl.text.isEmpty || confirmPasswordCtrl.text.isEmpty;

  bool isNewPasswordError() {
    final p = newPasswordCtrl.text;
    final c = confirmPasswordCtrl.text;
    return p.isNotEmpty && c.isNotEmpty && p != c;
  }

  bool isNewPasswordSuccess() {
    final p = newPasswordCtrl.text;
    final c = confirmPasswordCtrl.text;
    return p.isNotEmpty && c.isNotEmpty && p == c;
  }

  // ── Email Verification Timer ──
  void initEmailVerification() {
    emailVerificationButtonEnabled = false;
    emailVerificationTimerActive = true;
    emailVerificationSecondsLeft = 59;
    for (final c in emailVerificationControllers) {
      c.clear();
    }
    emailVerificationTimer?.stop();
    emailVerificationTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (s, c) {
        emailVerificationSecondsLeft = s;
        emailVerificationTimerActive = !c;
        if (!isClosed) emit(ForgotPasswordInitial());
      },
    )..start();
  }

  void checkEmailVerificationCompletion() {
    final done = emailVerificationControllers.every((c) => c.text.isNotEmpty);
    if (done != emailVerificationButtonEnabled) {
      emailVerificationButtonEnabled = done;
      if (!isClosed) emit(ForgotPasswordInitial());
    }
  }

  // ── Forgot Password ──
  static bool _isValidEmail(String e) =>
      RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(e);

  Future<void> forgotPassword(String email) async {
    if (!_isValidEmail(email)) {
      emit(ResetCodeSendFailure(message: 'Invalid email address'));
      return;
    }
    emit(ResetCodeSendLoading());
    final r = await authRepo.forgotPassword(email);
    if (isClosed) return;
    r.when(
      success: (m) => emit(ResetCodeSendSuccess(email: email, message: m)),
      failure: (e) => emit(
        ResetCodeSendFailure(message: e.message ?? 'Failed to send reset code'),
      ),
    );
  }

  void sendResetCode(String email) => forgotPassword(email);

  Future<void> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(ResetCodeVerifyLoading());
    final r = await authRepo.verifyResetOtp(email: email, otp: otp);
    if (isClosed) return;
    r.when(
      success: (_) => emit(ResetCodeVerifySuccess(email: email, code: otp)),
      failure: (e) =>
          emit(ResetCodeVerifyFailure(message: e.message ?? 'Invalid code')),
    );
  }

  void verifyResetCode(String email, String code) =>
      verifyResetOtp(email: email, otp: code);

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(PasswordResetLoading());
    final r = await authRepo.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
    if (isClosed) return;
    r.when(
      success: (m) => emit(PasswordResetSuccess(message: m)),
      failure: (e) => emit(
        PasswordResetFailure(message: e.message ?? 'Password reset failed'),
      ),
    );
  }

  void resetState() {
    newPasswordCtrl.clear();
    confirmPasswordCtrl.clear();
    if (!isClosed) emit(ForgotPasswordInitial());
  }

  // ── Password request reset (alternative flow) ──
  Future<void> passwordRequestReset(String email) async {
    emit(ResetCodeSendLoading());
    final r = await authRepo.passwordRequestReset(email);
    if (isClosed) return;
    r.when(
      success: (m) => emit(ResetCodeSendSuccess(email: email, message: m)),
      failure: (e) => emit(
        ResetCodeSendFailure(message: e.message ?? 'Failed to send reset code'),
      ),
    );
  }

  Future<void> passwordVerifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(ResetCodeVerifyLoading());
    final r = await authRepo.passwordVerifyOtp(email: email, otp: otp);
    if (isClosed) return;
    r.when(
      success: (_) => emit(ResetCodeVerifySuccess(email: email, code: otp)),
      failure: (e) =>
          emit(ResetCodeVerifyFailure(message: e.message ?? 'Invalid code')),
    );
  }

  // ── Dispose ──
  @override
  Future<void> close() {
    emailCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    resetCodeCtrl.dispose();
    resetFocusNode.dispose();
    for (final c in emailVerificationControllers) {
      c.dispose();
    }
    for (final n in emailVerificationFocusNodes) {
      n.dispose();
    }
    emailVerificationTimer?.stop();
    return super.close();
  }
}
