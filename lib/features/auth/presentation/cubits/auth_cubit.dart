import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request/auth_request.dart';
import '../../data/repos/auth_repo.dart';

import '../../logic/otp_timer.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  // ============================================================
  //  Controllers
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
  //  UI State
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
    newPasswordCtrl.addListener(_rebuild);
    confirmPasswordCtrl.addListener(_rebuild);
    otpCodeCtrl.addListener(_rebuild);
    resetCodeCtrl.addListener(_rebuild);
  }

  void _rebuild() {
    if (!isClosed) emit(AuthInitial());
  }

  // ============================================================
  //  UI Helpers
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
  //  UI Actions
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
  //  API: Login (POST /auth/login, /login/phone, /login/email, /google)
  // ============================================================

  /// Login with identifier (email or phone) - POST /auth/login
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

  /// Login with email - POST /auth/login/email
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await _authRepo.loginWithEmail(
      email: email,
      password: password,
    );
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        LoginSuccess(message: res.name != null ? 'مرحباً ${res.name}' : null),
      ),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'فشل تسجيل الدخول بالبريد')),
    );
  }

  /// Login with phone - POST /auth/login/phone
  Future<void> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await _authRepo.loginWithPhone(
      phone: phone,
      password: password,
    );
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        LoginSuccess(message: res.name != null ? 'مرحباً ${res.name}' : null),
      ),
      failure: (e) =>
          emit(LoginFailure(message: e.message ?? 'فشل تسجيل الدخول بالهاتف')),
    );
  }

  /// Google OAuth - POST /auth/google
  Future<void> signInWithGoogle({
    required String idToken,
    String? name,
    String? email,
    String? googleId,
    String? profilePicture,
  }) async {
    emit(LoginLoading());
    final result = await _authRepo.loginWithGoogle(
      idToken: idToken,
      name: name,
      email: email,
      googleId: googleId,
      profilePicture: profilePicture,
    );
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

  void loginAsGuest() => emit(GuestLoginSuccess());

  // ============================================================
  //  API: Registration Flow (with OTP)
  //  - POST /auth/register/email
  //  - POST /auth/register/verify-otp
  //  - POST /auth/register/complete
  //  - POST /auth/register
  //  - POST /auth/resend-otp
  //  - POST /auth/activate
  // ============================================================

  /// Send OTP to email for registration - POST /auth/register/email
  Future<void> sendRegistrationOtp(String email) async {
    emit(OtpSendLoading());
    final result = await _authRepo.sendRegistrationOtp(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpSendSuccess(email: email, message: msg)),
      failure: (e) =>
          emit(OtpSendFailure(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  /// Verify registration OTP - POST /auth/register/verify-otp
  Future<void> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    emit(OtpVerifyLoading());
    final result = await _authRepo.verifyRegistrationOtp(
      email: email,
      otp: otp,
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpVerifySuccess(email: email, message: msg)),
      failure: (e) =>
          emit(OtpVerifyFailure(message: e.message ?? 'كود غير صحيح')),
    );
  }

  /// Complete registration after OTP verification - POST /auth/register/complete
  Future<void> completeRegistration({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(CompleteProfileLoading());
    final result = await _authRepo.completeRegistration(
      CompleteProfileRequest(
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

  /// Direct registration (if used) - POST /auth/register
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String role = 'USER',
  }) async {
    emit(RegisterLoading());
    final result = await _authRepo.register(
      RegisterRequest(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: role,
      ),
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(RegisterSuccess(message: msg)),
      failure: (e) =>
          emit(RegisterFailure(message: e.message ?? 'فشل إنشاء الحساب')),
    );
  }

  /// Resend OTP - POST /auth/resend-otp
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

  /// Activate account - POST /auth/activate
  Future<void> activateAccount({
    required String email,
    required String otp,
  }) async {
    emit(ActivateAccountLoading());
    final result = await _authRepo.activateAccount(email: email, otp: otp);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(ActivateAccountSuccess(message: msg)),
      failure: (e) => emit(
        ActivateAccountFailure(message: e.message ?? 'فشل تفعيل الحساب'),
      ),
    );
  }

  // ============================================================
  //  API: Password Reset
  //  - POST /auth/forgot-password
  //  - POST /auth/verify-reset-otp
  //  - POST /auth/reset-password
  //  - POST /auth/password/request-reset
  //  - POST /auth/password/verify-otp
  //  - POST /auth/password/reset
  // ============================================================

  /// Forgot password - POST /auth/forgot-password
  Future<void> forgotPassword(String email) async {
    if (!_isValidEmail(email)) {
      emit(ResetCodeSendFailure(message: 'البريد الإلكتروني غير صحيح'));
      return;
    }
    emit(ResetCodeSendLoading());
    final result = await _authRepo.forgotPassword(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(ResetCodeSendSuccess(email: email, message: msg)),
      failure: (e) => emit(
        ResetCodeSendFailure(message: e.message ?? 'فشل إرسال كود الاستعادة'),
      ),
    );
  }

  /// Verify reset OTP - POST /auth/verify-reset-otp
  Future<void> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(ResetCodeVerifyLoading());
    final result = await _authRepo.verifyResetOtp(email: email, otp: otp);
    if (isClosed) return;
    result.when(
      success: (_) => emit(ResetCodeVerifySuccess(email: email, code: otp)),
      failure: (e) =>
          emit(ResetCodeVerifyFailure(message: e.message ?? 'كود غير صحيح')),
    );
  }

  /// Reset password - POST /auth/reset-password
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(PasswordResetLoading());
    final result = await _authRepo.resetPassword(
      email: email,
      otp: otp,
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

  /// Request password reset - POST /auth/password/request-reset
  Future<void> passwordRequestReset(String email) async {
    emit(ResetCodeSendLoading());
    final result = await _authRepo.passwordRequestReset(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(ResetCodeSendSuccess(email: email, message: msg)),
      failure: (e) => emit(
        ResetCodeSendFailure(message: e.message ?? 'فشل طلب إعادة التعيين'),
      ),
    );
  }

  /// Verify password reset OTP - POST /auth/password/verify-otp
  Future<void> passwordVerifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(ResetCodeVerifyLoading());
    final result = await _authRepo.passwordVerifyOtp(email: email, otp: otp);
    if (isClosed) return;
    result.when(
      success: (_) => emit(ResetCodeVerifySuccess(email: email, code: otp)),
      failure: (e) =>
          emit(ResetCodeVerifyFailure(message: e.message ?? 'كود غير صحيح')),
    );
  }

  /// Reset password using verified OTP - POST /auth/password/reset
  Future<void> passwordReset({
    required String email,
    required String otp,
    required String password,
  }) async {
    emit(PasswordResetLoading());
    final result = await _authRepo.passwordReset(
      email: email,
      otp: otp,
      password: password,
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(PasswordResetSuccess(message: msg)),
      failure: (e) => emit(
        PasswordResetFailure(
          message: e.message ?? 'فشل إعادة تعيين كلمة المرور',
        ),
      ),
    );
  }

  // ============================================================
  //  API: Refresh Token - POST /auth/refresh
  // ============================================================
  Future<void> refreshToken() async {
    emit(RefreshTokenLoading());
    final result = await _authRepo.refreshToken();
    if (isClosed) return;
    result.when(
      success: (res) => emit(
        RefreshTokenSuccess(
          message: res.name != null ? 'تم تحديث التوكن بنجاح' : null,
        ),
      ),
      failure: (e) =>
          emit(RefreshTokenFailure(message: e.message ?? 'فشل تحديث التوكن')),
    );
  }

  // ============================================================
  //  API: Logout - POST /auth/logout
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
