import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/complete_responses.dart';
import '../../data/models/register_responses.dart';
import '../../data/models/request/login_request_model.dart';
import '../../data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  // ──────────────────────────────────────────────────
  //  Controllers (owned by Cubit — per PROJECT_RULES.md)
  // ──────────────────────────────────────────────────

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController signUpEmailCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  // ──────────────────────────────────────────────────
  //  Form Keys
  // ──────────────────────────────────────────────────

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> completeProfileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  // ──────────────────────────────────────────────────
  //  Helpers
  // ──────────────────────────────────────────────────

  /// يرجّع الـ state لـ AuthInitial (مفيد في initState للشاشات)
  void resetState() => emit(AuthInitial());

  // ══════════════════════════════════════════════════
  //  Sign-In
  // ══════════════════════════════════════════════════

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await _authRepo.login(
      LoginRequestModel(identifier: identifier, password: password),
    );
    if (isClosed) return;
    result.when(
      success: (res) => emit(LoginSuccessState(message: res.name != null
          ? 'مرحباً ${res.name}'
          : null)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل تسجيل الدخول')),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'google'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(LoginSuccessState(message: res.name != null
          ? 'مرحباً ${res.name}'
          : null)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل تسجيل الدخول بـ Google')),
    );
  }

  Future<void> signInWithApple() async {
    emit(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'apple'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(LoginSuccessState(message: res.name != null
          ? 'مرحباً ${res.name}'
          : null)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل تسجيل الدخول بـ Apple')),
    );
  }

  Future<void> loginAsGuest() async {
    if (isClosed) return;
    emit(GuestLoginSuccessState());
  }

  // ══════════════════════════════════════════════════
  //  OTP / Registration Flow
  // ══════════════════════════════════════════════════

  /// إرسال OTP لبدء التسجيل
  Future<void> sendSmsCode(String email) async {
    emit(AuthLoadingState());
    final result = await _authRepo.sendSmsCode(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpSentState(email: email, message: msg)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  /// التحقق من OTP التسجيل
  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(AuthLoadingState());
    final result = await _authRepo.verifyOtp(email: phoneNumber, otp: otp);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpVerifiedState(email: phoneNumber, message: msg)),
      failure: (e) => emit(OtpErrorState(message: e.message ?? 'كود غير صحيح')),
    );
  }

  /// Login بالموبايل — يبعت OTP
  Future<void> loginWithPhone(String phone) async {
    emit(AuthLoadingState());
    final result = await _authRepo.loginWithPhone({'phone': phone});
    if (isClosed) return;
    result.when(
      success: (res) => emit(OtpSentState(email: phone)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل إرسال الكود')),
    );
  }

  /// إعادة إرسال OTP
  Future<void> resendOtp(String email) async {
    emit(AuthLoadingState());
    final result = await _authRepo.resendOtp(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(OtpSentState(email: email, message: msg)),
      failure: (e) => emit(OtpErrorState(message: e.message ?? 'فشل إعادة الإرسال')),
    );
  }

  // ══════════════════════════════════════════════════
  //  Complete Profile / Register
  // ══════════════════════════════════════════════════

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoadingState());
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
      success: (msg) => emit(RegisterSuccessState(message: msg)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل إنشاء الحساب')),
    );
  }

  Future<void> completeProfile({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await _authRepo.completeProfile(
      CompleteResponses(email: email, name: name, phone: phone, password: password),
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(RegisterSuccessState(message: msg)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل إتمام البروفايل')),
    );
  }

  Future<void> signUpWithGoogle() async {
    emit(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'google'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(RegisterSuccessState(message: res.name != null
          ? 'مرحباً ${res.name}'
          : null)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل التسجيل بـ Google')),
    );
  }

  Future<void> signUpWithApple() async {
    emit(AuthLoadingState());
    final result = await _authRepo.loginWithGoogle({'provider': 'apple'});
    if (isClosed) return;
    result.when(
      success: (res) => emit(RegisterSuccessState(message: res.name != null
          ? 'مرحباً ${res.name}'
          : null)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل التسجيل بـ Apple')),
    );
  }

  // ══════════════════════════════════════════════════
  //  Password Reset Flow
  // ══════════════════════════════════════════════════

  Future<void> sendResetCode(String email) async {
    emit(AuthLoadingState());
    final result = await _authRepo.sendResetCode(email);
    if (isClosed) return;
    result.when(
      success: (msg) => emit(ResetCodeSentState(email: email, message: msg)),
      failure: (e) => emit(AuthErrorState(message: e.message ?? 'فشل إرسال كود الاستعادة')),
    );
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(AuthLoadingState());
    final result = await _authRepo.verifyResetCode(email: email, otp: code);
    if (isClosed) return;
    result.when(
      success: (_) => emit(ResetCodeVerifiedState(email: email, code: code)),
      failure: (e) => emit(ResetCodeError(message: e.message ?? 'كود غير صحيح')),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(AuthLoadingState());
    final result = await _authRepo.resetPassword(
      email: email,
      otp: code,
      newPassword: newPassword,
    );
    if (isClosed) return;
    result.when(
      success: (msg) => emit(PasswordResetSuccessState(message: msg)),
      failure: (e) => emit(PasswordResetErrorState(message: e.message ?? 'فشل تغيير كلمة المرور')),
    );
  }

  // ══════════════════════════════════════════════════
  //  Session
  // ══════════════════════════════════════════════════

  Future<void> signOut() async {
    emit(AuthLoadingState());
    await _authRepo.signOut();
    if (isClosed) return;
    emit(SignOutSuccessState());
  }

  // ══════════════════════════════════════════════════
  //  Dispose
  // ══════════════════════════════════════════════════

  @override
  Future<void> close() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    signUpEmailCtrl.dispose();
    nameCtrl.dispose();
    phoneCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    return super.close();
  }
}
