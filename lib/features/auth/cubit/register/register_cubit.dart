import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/auth_constants.dart';
import '../../data/models/request/auth_request.dart';
import '../../data/repos/auth_repo.dart';
import '../../presentation/logic/otp_timer.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial());

  // ── Controllers ──
  final signUpEmailCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final otpCodeCtrl = TextEditingController();
  final otpFocusNode = FocusNode();

  // ── OTP Timer State ──
  bool otpInitialized = false;
  int otpSecondsLeft = AuthConstants.otpTimerSeconds;
  bool otpCanResend = false;
  OtpTimer? otpTimer;
  final otpTimerNotifier = ValueNotifier<OtpTimerValue>(
    OtpTimerValue(secondsLeft: AuthConstants.otpTimerSeconds, canResend: false),
  );

  // ── OTP Timer ──
  void initOtp(String email) {
    otpInitialized = true;
    otpCanResend = false;
    otpSecondsLeft = AuthConstants.otpTimerSeconds;
    otpTimerNotifier.value = OtpTimerValue(
      secondsLeft: AuthConstants.otpTimerSeconds,
      canResend: false,
    );
    otpCodeCtrl.clear();
    otpTimer?.stop();
    otpTimer = OtpTimer(
      totalSeconds: AuthConstants.otpTimerSeconds,
      onTick: (s, c) {
        otpSecondsLeft = s;
        otpCanResend = c;
        otpTimerNotifier.value = OtpTimerValue(secondsLeft: s, canResend: c);
      },
      onFinished: () {
        if (!isClosed) resendOtp(email);
      },
    )..start();
  }

  // ── Registration ──
  Future<void> sendRegistrationOtp(String email) async {
    emit(OtpSendLoading());
    final r = await authRepo.sendRegistrationOtp(email);
    if (isClosed) return;
    r.when(
      success: (m) => emit(OtpSendSuccess(email: email, message: m)),
      failure: (e) {
        log(e.message.toString());

        emit(OtpSendFailure(message: e.message ?? 'Failed to send code'));
      },
    );
  }

  void sendSignUpSmsCode() {
    final e = signUpEmailCtrl.text.trim();
    if (e.isNotEmpty) sendRegistrationOtp(e);
  }

  Future<void> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    emit(OtpVerifyLoading());
    final r = await authRepo.verifyRegistrationOtp(email: email, otp: otp);
    if (isClosed) return;
    r.when(
      success: (m) => emit(OtpVerifySuccess(email: email, message: m)),
      failure: (e) {
        otpCodeCtrl.clear();
        emit(OtpVerifyFailure(message: e.message ?? 'Invalid code'));
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!isClosed) emit(RegisterInitial());
        });
      },
    );
  }

  void verifyOtp({required String phoneNumber, required String otp}) =>
      verifyRegistrationOtp(email: phoneNumber, otp: otp);

  Future<void> completeRegistration({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(CompleteProfileLoading());
    final r = await authRepo.completeRegistration(
      CompleteProfileRequest(
        email: email,
        name: name,
        phone: phone,
        password: password,
      ),
    );
    if (isClosed) return;
    r.when(
      success: (m) => emit(CompleteProfileSuccess(message: m)),
      failure: (e) => emit(
        CompleteProfileFailure(
          message: e.message ?? 'Profile completion failed',
        ),
      ),
    );
  }

  Future<void> resendOtp(String email) async {
    emit(OtpSendLoading());
    final r = await authRepo.resendOtp(email);
    if (isClosed) return;
    r.when(
      success: (m) {
        initOtp(email);
        emit(OtpSendSuccess(email: email, message: m));
      },
      failure: (e) {
        otpTimer?.stop();
        otpCanResend = true;
        otpSecondsLeft = 0;
        otpTimerNotifier.value = const OtpTimerValue(
          secondsLeft: 0,
          canResend: true,
        );
        emit(OtpSendFailure(message: e.message ?? 'Failed to resend code'));
      },
    );
  }

  void signUpWithGoogle() {
    emit(OtpSendFailure(message: 'Google sign-up requires web OAuth setup'));
  }

  void signUpWithApple() {
    emit(OtpSendFailure(message: 'Apple sign-up is not yet supported'));
  }

  // ── Dispose ──
  @override
  Future<void> close() async {
    signUpEmailCtrl.dispose();
    emailCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    otpCodeCtrl.dispose();
    otpFocusNode.dispose();
    otpTimer?.stop();
    otpTimerNotifier.dispose();
    return super.close();
  }
}

class OtpTimerValue {
  final int secondsLeft;
  final bool canResend;
  const OtpTimerValue({required this.secondsLeft, required this.canResend});
}
