import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request/auth_request.dart';
import '../../data/repos/auth_repo.dart';
import '../../logic/auth_animation.dart';
import '../../logic/otp_timer.dart';
import '../screens/otp/widgets/otp_field_state.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial()) {
    newPasswordCtrl.addListener(_rebuild);
    confirmPasswordCtrl.addListener(_rebuild);
    otpCodeCtrl.addListener(_rebuild);
    resetCodeCtrl.addListener(_rebuild);
  }

  // ── Controllers ────────────────────────────────────────────
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final signUpEmailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final otpCodeCtrl = TextEditingController();
  final resetCodeCtrl = TextEditingController();
  final otpFocusNode = FocusNode();
  final resetFocusNode = FocusNode();
  final emailVerificationControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final emailVerificationFocusNodes = List.generate(6, (_) => FocusNode());
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final completeProfileFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  // ── UI State ───────────────────────────────────────────────
  bool rememberMe = false;
  bool hasSignInError = false;
  bool signUpHasError = false;
  String? signUpErrorMessage;
  OtpFieldState otpFieldState = OtpFieldState.idle;
  int otpSecondsLeft = 59;
  bool otpCanResend = false;
  OtpTimer? otpTimer;
  bool otpInitialized = false;
  final otpAnimation = AuthAnimation();
  OtpFieldState resetFieldState = OtpFieldState.idle;
  final resetAnimation = AuthAnimation();
  bool obscureCompleteProfilePass = true;
  bool obscureCompleteProfileConfirm = true;
  bool obscureNewPassword = true;
  bool obscureConfirmNewPassword = true;
  OtpTimer? emailVerificationTimer;
  int emailVerificationSecondsLeft = 59;
  bool emailVerificationTimerActive = true;
  bool emailVerificationButtonEnabled = false;

  // ── Helpers ────────────────────────────────────────────────
  bool get isLoading =>
      state is LoginLoading ||
      state is RegisterLoading ||
      state is OtpSendLoading ||
      state is OtpVerifyLoading ||
      state is ResetCodeSendLoading ||
      state is ResetCodeVerifyLoading ||
      state is CompleteProfileLoading ||
      state is PasswordResetLoading ||
      state is ActivateAccountLoading ||
      state is RefreshTokenLoading ||
      state is SignOutLoading;

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

  void _rebuild() {
    if (!isClosed) emit(AuthInitial());
  }

  // ── UI Actions ─────────────────────────────────────────────
  void toggleRememberMe(bool v) {
    rememberMe = v;
    emit(AuthInitial());
  }

  void setSignInError(bool v) {
    hasSignInError = v;
    emit(AuthInitial());
  }

  void setSignUpError(bool hasError, [String? msg]) {
    signUpHasError = hasError;
    signUpErrorMessage = msg;
    emit(AuthInitial());
  }

  void toggleCompleteProfilePass() {
    obscureCompleteProfilePass = !obscureCompleteProfilePass;
    emit(AuthInitial());
  }

  void toggleCompleteProfileConfirm() {
    obscureCompleteProfileConfirm = !obscureCompleteProfileConfirm;
    emit(AuthInitial());
  }

  void toggleNewPasswordObscure() {
    obscureNewPassword = !obscureNewPassword;
    emit(AuthInitial());
  }

  void toggleConfirmNewPasswordObscure() {
    obscureConfirmNewPassword = !obscureConfirmNewPassword;
    emit(AuthInitial());
  }

  // ── OTP Timer ──────────────────────────────────────────────
  void initOtp(String email) {
    otpInitialized = true;
    otpFieldState = OtpFieldState.idle;
    otpCanResend = false;
    otpSecondsLeft = 59;
    otpCodeCtrl.clear();
    otpTimer?.stop();
    otpTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (s, c) {
        otpSecondsLeft = s;
        otpCanResend = c;
        emit(AuthInitial());
      },
    )..start();
  }

  void setOtpFieldState(OtpFieldState s) {
    otpFieldState = s;
    emit(AuthInitial());
  }

  void setResetFieldState(OtpFieldState s) {
    resetFieldState = s;
    emit(AuthInitial());
  }

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
        emit(AuthInitial());
      },
    )..start();
  }

  void checkEmailVerificationCompletion() {
    final done = emailVerificationControllers.every((c) => c.text.isNotEmpty);
    if (done != emailVerificationButtonEnabled) {
      emailVerificationButtonEnabled = done;
      emit(AuthInitial());
    }
  }

  // ── Login ──────────────────────────────────────────────────
  Future<void> login(String identifier, String password) async {
    if (identifier.trim().isEmpty || password.isEmpty) {
      hasSignInError = true;
      emit(LoginFailure(message: 'Email and password are required'));
      return;
    }
    hasSignInError = false;
    emit(LoginLoading());
    final r = await authRepo.login(
      LoginRequestModel(identifier: identifier, password: password),
    );
    if (isClosed) return;
    r.when(
      success: (d) => emit(LoginSuccess(message: d.name)),
      failure: (e) => emit(LoginFailure(message: e.message ?? 'Login failed')),
    );
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final r = await authRepo.loginWithEmail(email: email, password: password);
    if (isClosed) return;
    r.when(
      success: (d) => emit(LoginSuccess(message: d.name)),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'Email login failed')),
    );
  }

  Future<void> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoading());
    final r = await authRepo.loginWithPhone(phone: phone, password: password);
    if (isClosed) return;
    r.when(
      success: (d) => emit(LoginSuccess(message: d.name)),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'Phone login failed')),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final r = await authRepo.loginWithGoogle(idToken: '');
    if (isClosed) return;
    r.when(
      success: (d) => emit(LoginSuccess(message: d.name)),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'Google sign-in failed')),
    );
  }

  void signInWithApple() {
    emit(LoginFailure(message: 'Apple sign-in is not yet supported'));
  }

  void loginAsGuest() => emit(GuestLoginSuccess());

  // ── Registration ───────────────────────────────────────────
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

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String role = 'USER',
  }) async {
    emit(RegisterLoading());
    final r = await authRepo.register(
      RegisterRequest(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: role,
      ),
    );
    if (isClosed) return;
    r.when(
      success: (m) => emit(RegisterSuccess(message: m)),
      failure: (e) =>
          emit(RegisterFailure(message: e.message ?? 'Registration failed')),
    );
  }

  void sendSignUpSmsCode() {
    final e = signUpEmailCtrl.text.trim();
    if (e.isNotEmpty) sendRegistrationOtp(e);
  }

  void signUpWithGoogle() {
    emit(RegisterFailure(message: 'Google sign-up requires web OAuth setup'));
  }

  void signUpWithApple() {
    emit(RegisterFailure(message: 'Apple sign-up is not yet supported'));
  }

  // ── Password Reset ─────────────────────────────────────────
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
  void verifyOtp({required String phoneNumber, required String otp}) =>
      verifyRegistrationOtp(email: phoneNumber, otp: otp);

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
    emit(AuthInitial());
  }

  // ── Session ────────────────────────────────────────────────
  Future<void> refreshToken() async {
    emit(RefreshTokenLoading());
    final r = await authRepo.refreshToken();
    if (isClosed) return;
    r.when(
      success: (d) => emit(RefreshTokenSuccess(message: d.name)),
      failure: (e) => emit(
        RefreshTokenFailure(message: e.message ?? 'Token refresh failed'),
      ),
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoading());
    await authRepo.signOut();
    if (isClosed) return;
    emit(SignOutSuccess());
  }

  // ── Dispose ────────────────────────────────────────────────
  @override
  Future<void> close() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    signUpEmailCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    otpCodeCtrl.dispose();
    resetCodeCtrl.dispose();
    otpFocusNode.dispose();
    resetFocusNode.dispose();
    for (final c in emailVerificationControllers) { c.dispose(); }
    for (final n in emailVerificationFocusNodes) { n.dispose(); }
    otpTimer?.stop();
    emailVerificationTimer?.stop();
    otpAnimation.dispose();
    resetAnimation.dispose();
    return super.close();
  }
}
