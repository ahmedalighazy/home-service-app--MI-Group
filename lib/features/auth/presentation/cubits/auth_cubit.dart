import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/auth_repo.dart';
import '../../logic/auth_controllers.dart';
import '../../logic/auth_ui_state.dart';
import '../../logic/sign_in_logic.dart';
import '../../logic/sign_up_logic.dart';
import '../../logic/reset_password_logic.dart';
import '../../logic/otp_logic.dart';
import '../../logic/session_logic.dart';
import '../../logic/otp_timer.dart';
import '../../logic/validators/sign_up_validator.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthControllers controllers = AuthControllers();
  final AuthUiState uiState = AuthUiState();

  final SignInLogic signInLogic;
  final SignUpLogic signUpLogic;
  final ResetPasswordLogic resetPasswordLogic;
  final OtpLogic otpLogic;
  final SessionLogic sessionLogic;

  AuthCubit(AuthRepo authRepo)
      : signInLogic = SignInLogic(authRepo),
        signUpLogic = SignUpLogic(authRepo),
        resetPasswordLogic = ResetPasswordLogic(authRepo),
        otpLogic = OtpLogic(authRepo),
        sessionLogic = SessionLogic(authRepo),
        super(AuthInitial()) {
    controllers.newPasswordCtrl.addListener(_rebuild);
    controllers.confirmPasswordCtrl.addListener(_rebuild);
    controllers.otpCodeCtrl.addListener(_rebuild);
    controllers.resetCodeCtrl.addListener(_rebuild);
  }

  void _rebuild() {
    if (!isClosed) emit(AuthInitial());
  }

  void emitState(AuthState state) {
    if (!isClosed) emit(state);
  }

  void resetState() => emit(AuthInitial());

  @override
  Future<void> close() {
    controllers.dispose();
    uiState.dispose();
    return super.close();
  }
}

extension AuthCubitGetters on AuthCubit {
  TextEditingController get emailCtrl => controllers.emailCtrl;
  TextEditingController get passwordCtrl => controllers.passwordCtrl;
  TextEditingController get signUpEmailCtrl => controllers.signUpEmailCtrl;
  TextEditingController get nameCtrl => controllers.nameCtrl;
  TextEditingController get phoneCtrl => controllers.phoneCtrl;
  TextEditingController get newPasswordCtrl => controllers.newPasswordCtrl;
  TextEditingController get confirmPasswordCtrl => controllers.confirmPasswordCtrl;
  TextEditingController get otpCodeCtrl => controllers.otpCodeCtrl;
  TextEditingController get resetCodeCtrl => controllers.resetCodeCtrl;

  GlobalKey<FormState> get signInFormKey => controllers.signInFormKey;
  GlobalKey<FormState> get signUpFormKey => controllers.signUpFormKey;
  GlobalKey<FormState> get completeProfileFormKey => controllers.completeProfileFormKey;
  GlobalKey<FormState> get resetPasswordFormKey => controllers.resetPasswordFormKey;

  bool get rememberMe => uiState.rememberMe;
  bool get hasSignInError => uiState.hasSignInError;
  bool get signUpHasError => uiState.signUpHasError;
  String? get signUpErrorMessage => uiState.signUpErrorMessage;
}

extension AuthCubitUiActions on AuthCubit {
  void toggleRememberMe(bool value) {
    uiState.rememberMe = value;
    emitState(AuthInitial());
  }

  void setSignInError(bool value) {
    uiState.hasSignInError = value;
    emitState(AuthInitial());
  }

  void setSignUpError(bool hasError, [String? message]) {
    uiState.signUpHasError = hasError;
    uiState.signUpErrorMessage = message;
    emitState(AuthInitial());
  }

  void sendSignUpSmsCode() {
    final email = controllers.signUpEmailCtrl.text.trim();
    final error = SignUpValidator.validateEmail(email);
    if (error != null) {
      setSignUpError(true, error);
      return;
    }
    setSignUpError(false, null);
    sendSmsCode(email);
  }

  void toggleCompleteProfilePass() {
    uiState.obscureCompleteProfilePass = !uiState.obscureCompleteProfilePass;
    emitState(AuthInitial());
  }

  void toggleCompleteProfileConfirm() {
    uiState.obscureCompleteProfileConfirm = !uiState.obscureCompleteProfileConfirm;
    emitState(AuthInitial());
  }

  void toggleNewPasswordObscure() {
    uiState.obscureNewPassword = !uiState.obscureNewPassword;
    emitState(AuthInitial());
  }

  void toggleConfirmNewPasswordObscure() {
    uiState.obscureConfirmNewPassword = !uiState.obscureConfirmNewPassword;
    emitState(AuthInitial());
  }

  bool isNewPasswordEmpty() {
    return controllers.newPasswordCtrl.text.isEmpty || controllers.confirmPasswordCtrl.text.isEmpty;
  }

  bool isNewPasswordError() {
    final pass = controllers.newPasswordCtrl.text;
    final confirm = controllers.confirmPasswordCtrl.text;
    return pass.isNotEmpty && confirm.isNotEmpty && pass != confirm;
  }

  bool isNewPasswordSuccess() {
    final pass = controllers.newPasswordCtrl.text;
    final confirm = controllers.confirmPasswordCtrl.text;
    return pass.isNotEmpty && confirm.isNotEmpty && pass == confirm;
  }

  void initOtp(String email) {
    uiState.otpInitialized = true;
    uiState.otpFieldState = OtpFieldState.idle;
    uiState.otpCanResend = false;
    uiState.otpSecondsLeft = 59;
    controllers.otpCodeCtrl.clear();
    
    uiState.otpTimer?.stop();
    uiState.otpTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (secondsLeft, canResend) {
        uiState.otpSecondsLeft = secondsLeft;
        uiState.otpCanResend = canResend;
        emitState(AuthInitial());
      },
    )..start();
  }

  void setOtpFieldState(OtpFieldState state) {
    uiState.otpFieldState = state;
    emitState(AuthInitial());
  }

  void setResetFieldState(OtpFieldState state) {
    uiState.resetFieldState = state;
    emitState(AuthInitial());
  }

  void initEmailVerification() {
    uiState.emailVerificationButtonEnabled = false;
    uiState.emailVerificationTimerActive = true;
    uiState.emailVerificationSecondsLeft = 59;
    
    for (var c in controllers.emailVerificationControllers) {
      c.clear();
    }

    uiState.emailVerificationTimer?.stop();
    uiState.emailVerificationTimer = OtpTimer(
      totalSeconds: 59,
      onTick: (secondsLeft, canResend) {
        uiState.emailVerificationSecondsLeft = secondsLeft;
        uiState.emailVerificationTimerActive = !canResend;
        emitState(AuthInitial());
      },
    )..start();
  }

  void checkEmailVerificationCompletion() {
    final completed = controllers.emailVerificationControllers.every((c) => c.text.isNotEmpty);
    if (completed != uiState.emailVerificationButtonEnabled) {
      uiState.emailVerificationButtonEnabled = completed;
      emitState(AuthInitial());
    }
  }

  String get emailVerificationOtpCode => controllers.emailVerificationControllers.map((c) => c.text).join();
}

extension AuthCubitRepoActions on AuthCubit {
  Future<void> login({required String identifier, required String password}) =>
      signInLogic.login(this, identifier: identifier, password: password);

  Future<void> signInWithGoogle() => signInLogic.signInWithGoogle(this);
  Future<void> signInWithApple() => signInLogic.signInWithApple(this);
  Future<void> loginAsGuest() async => signInLogic.loginAsGuest(this);

  Future<void> sendSmsCode(String email) => otpLogic.sendSmsCode(this, email);
  Future<void> verifyOtp({required String phoneNumber, required String otp}) =>
      otpLogic.verifyOtp(this, phoneNumber: phoneNumber, otp: otp);

  Future<void> loginWithPhone(String phone) => otpLogic.loginWithPhone(this, phone);
  Future<void> resendOtp(String email) => otpLogic.resendOtp(this, email);

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) =>
      signUpLogic.register(this, name: name, email: email, phone: phone, password: password);

  Future<void> completeProfile({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) =>
      signUpLogic.completeProfile(this, email: email, name: name, phone: phone, password: password);

  Future<void> signUpWithGoogle() => signUpLogic.signUpWithGoogle(this);
  Future<void> signUpWithApple() => signUpLogic.signUpWithApple(this);

  Future<void> sendResetCode(String email) => resetPasswordLogic.sendResetCode(this, email);
  Future<void> verifyResetCode(String email, String code) =>
      resetPasswordLogic.verifyResetCode(this, email, code);

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) =>
      resetPasswordLogic.resetPassword(this, email: email, code: code, newPassword: newPassword);

  Future<void> signOut() => sessionLogic.signOut(this);
}
