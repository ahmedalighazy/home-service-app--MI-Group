import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request/auth_request.dart';
import '../../data/repos/auth_repo.dart';
import '../../logic/otp_timer.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial()) {
    newPasswordCtrl.addListener(_rebuild);
    confirmPasswordCtrl.addListener(_rebuild);
    otpCodeCtrl.addListener(_rebuild);
  }

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
  int otpSecondsLeft = 59;
  bool otpCanResend = false;
  OtpTimer? otpTimer;

  void _rebuild() {
    if (!isClosed) emit(RegisterInitial());
  }

  // ── OTP Timer ──
  void initOtp(String email) {
    otpInitialized = true;
    otpCanResend = false;
    otpSecondsLeft = 59;
    otpCodeCtrl.clear();
    otpTimer?.stop();
    otpTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (s, c) {
        otpSecondsLeft = s;
        otpCanResend = c;
        if (!isClosed) emit(RegisterInitial());
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
      failure: (e) =>
          emit(OtpSendFailure(message: e.message ?? 'Failed to send code')),
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
      failure: (e) =>
          emit(OtpVerifyFailure(message: e.message ?? 'Invalid code')),
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
      failure: (e) =>
          emit(OtpSendFailure(message: e.message ?? 'Failed to resend code')),
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
  Future<void> close() {
    signUpEmailCtrl.dispose();
    emailCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    otpCodeCtrl.dispose();
    otpFocusNode.dispose();
    otpTimer?.stop();
    return super.close();
  }
}
