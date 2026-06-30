import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/complete_responses.dart';
import '../../data/models/register_responses.dart';
import '../../data/models/request/login_request_model.dart';
import '../../data/repos/auth_repo.dart';

import '../../logic/otp_timer.dart';
import '../../logic/validators/sign_up_validator.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';

part 'auth_state.dart';

//////////////////

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  // ============================================================
  //  Controllers (formerly AuthControllers)
  // ============================================================
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

  // ============================================================
  //  UI State (formerly AuthUiState)
  // ============================================================
  bool rememberMe = false;
  bool hasSignInError = false;
  bool signUpHasError = false;
  String? signUpErrorMessage;

  OtpFieldState otpFieldState = OtpFieldState.idle;
  int otpSecondsLeft = 59;
  bool otpCanResend = false;
  OtpTimer? otpTimer;
  bool otpInitialized = false;

  OtpFieldState resetFieldState = OtpFieldState.idle;

  bool obscureCompleteProfilePass = true;
  bool obscureCompleteProfileConfirm = true;

  bool obscureNewPassword = true;
  bool obscureConfirmNewPassword = true;

  OtpTimer? emailVerificationTimer;
  int emailVerificationSecondsLeft = 59;
  bool emailVerificationTimerActive = true;
  bool emailVerificationButtonEnabled = false;

  AuthCubit(this._authRepo) : super(AuthInitial()) {
    // Listen to text changes for password validation UI
    newPasswordCtrl.addListener(_rebuild);
    confirmPasswordCtrl.addListener(_rebuild);
    otpCodeCtrl.addListener(_rebuild);
    resetCodeCtrl.addListener(_rebuild);
  }

  void _rebuild() {
    if (!isClosed) emit(AuthInitial());
  }

  // ============================================================
  //  UI Helpers (formerly extension getters & actions)
  // ============================================================
  String get emailVerificationOtpCode =>
      emailVerificationControllers.map((c) => c.text).join();

  bool isNewPasswordEmpty() =>
      newPasswordCtrl.text.isEmpty || confirmPasswordCtrl.text.isEmpty;

  bool isNewPasswordError() {
    final pass = newPasswordCtrl.text;
    final confirm = confirmPasswordCtrl.text;
    return pass.isNotEmpty && confirm.isNotEmpty && pass != confirm;
  }

  bool isNewPasswordSuccess() {
    final pass = newPasswordCtrl.text;
    final confirm = confirmPasswordCtrl.text;
    return pass.isNotEmpty && confirm.isNotEmpty && pass == confirm;
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);

  // ============================================================
  //  UI Actions (toggle states)
  // ============================================================
  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(AuthInitial());
  }

  void setSignInError(bool value) {
    hasSignInError = value;
    emit(AuthInitial());
  }

  void setSignUpError(bool hasError, [String? message]) {
    signUpHasError = hasError;
    signUpErrorMessage = message;
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

  // ============================================================
  //  OTP Timer
  // ============================================================
  void initOtp(String email) {
    otpInitialized = true;
    otpFieldState = OtpFieldState.idle;
    otpCanResend = false;
    otpSecondsLeft = 59;
    otpCodeCtrl.clear();

    otpTimer?.stop();
    otpTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (secondsLeft, canResend) {
        otpSecondsLeft = secondsLeft;
        otpCanResend = canResend;
        emit(AuthInitial());
      },
    )..start();
  }

  void setOtpFieldState(OtpFieldState state) {
    otpFieldState = state;
    emit(AuthInitial());
  }

  void setResetFieldState(OtpFieldState state) {
    resetFieldState = state;
    emit(AuthInitial());
  }

  void initEmailVerification() {
    emailVerificationButtonEnabled = false;
    emailVerificationTimerActive = true;
    emailVerificationSecondsLeft = 59;

    for (var c in emailVerificationControllers) {
      c.clear();
    }

    emailVerificationTimer?.stop();
    emailVerificationTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (secondsLeft, canResend) {
        emailVerificationSecondsLeft = secondsLeft;
        emailVerificationTimerActive = !canResend;
        emit(AuthInitial());
      },
    )..start();
  }

  void checkEmailVerificationCompletion() {
    final completed = emailVerificationControllers.every(
      (c) => c.text.isNotEmpty,
    );
    if (completed != emailVerificationButtonEnabled) {
      emailVerificationButtonEnabled = completed;
      emit(AuthInitial());
    }
  }

  // ============================================================
  //  API: Login
  // ============================================================
  Future<void> login(
    String identifier,
    String password,
    BuildContext context,
  ) async {
    if (identifier.trim().isEmpty || password.isEmpty) {
      setSignInError(true);
      emit(LoginFailure(message: context.tr('errorFieldRequired')));
      return;
    }
    setSignInError(false);
    emit(LoginLoading());
    final result = await _authRepo.login(
      LoginRequestModel(identifier: identifier, password: password),
    );
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        LoginSuccess(message: res.name != null ? 'مرحباً ${res.name}' : null),
      ),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'فشل تسجيل الدخول')),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final result = await _authRepo.loginWithGoogle({'provider': 'google'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        LoginSuccess(message: res.name != null ? 'مرحباً ${res.name}' : null),
      ),
      failure: (e) => emit(
        LoginFailure(message: e.message ?? 'فشل تسجيل الدخول بـ Google'),
      ),
    );
  }

  Future<void> signInWithApple() async {
    emit(LoginLoading());
    final result = await _authRepo.loginWithGoogle({'provider': 'apple'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        LoginSuccess(message: res.name != null ? 'مرحباً ${res.name}' : null),
      ),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'فشل تسجيل الدخول بـ Apple')),
    );
  }

  void loginAsGuest() => emit(GuestLoginSuccess());

  // ============================================================
  //  API: OTP
  // ============================================================
  Future<void> sendSmsCode(String email) async {
    emit(OtpSendLoading());
    final result = await _authRepo.sendSmsCode(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpSendSuccess(email: email, message: msg)),
      failure: (e) =>
          emit(OtpSendFailure(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  Future<void> verifyOtp(String phoneNumber, String otp) async {
    emit(OtpVerifyLoading());
    final result = await _authRepo.verifyOtp(email: phoneNumber, otp: otp);
    if (isClosed) return;
    result.when(
      success: (msg) =>
          emit(OtpVerifySuccess(email: phoneNumber, message: msg)),
      failure: (e) =>
          emit(OtpVerifyFailure(message: e.message ?? 'كود غير صحيح')),
    );
  }

  Future<void> loginWithPhone(String phone) async {
    emit(OtpSendLoading());
    final result = await _authRepo.loginWithPhone({'phone': phone});
    if (isClosed) return;
    result.when(
      success: (_) => emit(OtpSendSuccess(email: phone)),
      failure: (e) =>
          emit(OtpSendFailure(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  Future<void> resendOtp(String email) async {
    emit(OtpSendLoading());
    final result = await _authRepo.resendOtp(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpSendSuccess(email: email, message: msg)),
      failure: (e) =>
          emit(OtpSendFailure(message: e.message ?? 'فشل إعادة الإرسال')),
    );
  }

  // ============================================================
  //  API: Register
  // ============================================================
  Future<void> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    emit(RegisterLoading());
    final result = await _authRepo.register(
      RegisterResponses(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: 'user',
      ),
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(RegisterSuccess(message: msg)),
      failure: (e) =>
          emit(RegisterFailure(message: e.message ?? 'فشل إنشاء الحساب')),
    );
  }

  Future<void> completeProfile(
    String email,
    String name,
    String phone,
    String password,
  ) async {
    emit(CompleteProfileLoading());
    final result = await _authRepo.completeProfile(
      CompleteResponses(
        email: email,
        name: name,
        phone: phone,
        password: password,
      ),
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(CompleteProfileSuccess(message: msg)),
      failure: (e) => emit(
        CompleteProfileFailure(message: e.message ?? 'فشل إتمام البروفايل'),
      ),
    );
  }

  Future<void> signUpWithGoogle() async {
    emit(RegisterLoading());
    final result = await _authRepo.loginWithGoogle({'provider': 'google'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        RegisterSuccess(
          message: res.name != null ? 'مرحباً ${res.name}' : null,
        ),
      ),
      failure: (e) =>
          emit(RegisterFailure(message: e.message ?? 'فشل التسجيل بـ Google')),
    );
  }

  Future<void> signUpWithApple() async {
    emit(RegisterLoading());
    final result = await _authRepo.loginWithGoogle({'provider': 'apple'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        RegisterSuccess(
          message: res.name != null ? 'مرحباً ${res.name}' : null,
        ),
      ),
      failure: (e) =>
          emit(RegisterFailure(message: e.message ?? 'فشل التسجيل بـ Apple')),
    );
  }

  // ============================================================
  //  API: Reset Password (formerly ForgetPasswordCubit)
  // ============================================================
  Future<void> sendResetCode(String email) async {
    if (!_isValidEmail(email)) {
      emit(ResetCodeSendFailure(message: 'البريد الإلكتروني غير صحيح'));
      return;
    }
    emit(ResetCodeSendLoading());
    final result = await _authRepo.sendResetCode(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(ResetCodeSendSuccess(email: email, message: msg)),
      failure: (e) => emit(
        ResetCodeSendFailure(message: e.message ?? 'فشل إرسال كود الاستعادة'),
      ),
    );
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(ResetCodeVerifyLoading());
    final result = await _authRepo.verifyResetCode(email: email, otp: code);
    if (isClosed) return;
    result.when(
      success: (_) => emit(ResetCodeVerifySuccess(email: email, code: code)),
      failure: (e) =>
          emit(ResetCodeVerifyFailure(message: e.message ?? 'كود غير صحيح')),
    );
  }

  Future<void> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    emit(PasswordResetLoading());
    final result = await _authRepo.resetPassword(
      email: email,
      otp: code,
      newPassword: newPassword,
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(PasswordResetSuccess(message: msg)),
      failure: (e) => emit(
        PasswordResetFailure(message: e.message ?? 'فشل تغيير كلمة المرور'),
      ),
    );
  }

  // ============================================================
  //  API: Sign Out
  // ============================================================
  Future<void> signOut() async {
    emit(SignOutLoading());
    await _authRepo.signOut();
    if (isClosed) return;
    emit(SignOutSuccess());
  }

  // ============================================================
  //  Dispose
  // ============================================================
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
    for (final ctrl in emailVerificationControllers) {
      ctrl.dispose();
    }
    for (final node in emailVerificationFocusNodes) {
      node.dispose();
    }
    otpTimer?.stop();
    emailVerificationTimer?.stop();
    return super.close();
  }
}
