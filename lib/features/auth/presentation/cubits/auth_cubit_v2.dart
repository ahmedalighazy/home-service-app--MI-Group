import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/auth_state.dart';
import 'package:home_service_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:home_service_app/features/auth/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Auth Cubit (Improved Version) - Presentation Layer
/// 
/// Manages authentication state by calling UseCases
/// Each method delegates to appropriate UseCase
class AuthCubitV2 extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final CompleteProfileUseCase _completeProfileUseCase;
  final RequestPasswordResetUseCase _requestPasswordResetUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;

  AuthCubitV2({
    required SignInUseCase signInUseCase,
    required SendOtpUseCase sendOtpUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required CompleteProfileUseCase completeProfileUseCase,
    required RequestPasswordResetUseCase requestPasswordResetUseCase,
    required VerifyResetCodeUseCase verifyResetCodeUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignInWithAppleUseCase signInWithAppleUseCase,
  })  : _signInUseCase = signInUseCase,
        _sendOtpUseCase = sendOtpUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _completeProfileUseCase = completeProfileUseCase,
        _requestPasswordResetUseCase = requestPasswordResetUseCase,
        _verifyResetCodeUseCase = verifyResetCodeUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signInWithAppleUseCase = signInWithAppleUseCase,
        super(const AuthInitialState());

  // ════════════════════════════════════════════════════════════════
  // Sign In
  // ════════════════════════════════════════════════════════════════

  Future<void> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(const AuthLoadingState());

    final result = await _signInUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('rememberMe', rememberMe);
        // Persist email in SharedPreferences
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', email);
        await prefsAuth.remove('displayName'); // clear if any
        emit(AuthAuthenticated(email: email));
      },
    );
  }

  // ════════════════════════════════════════════════════════════════
  // Sign Up - OTP Flow
  // ════════════════════════════════════════════════════════════════

  Future<void> sendOtp({
    required String phoneNumber,
  }) async {
    emit(const AuthLoadingState());

    final result = await _sendOtpUseCase(phone: phoneNumber);

    result.fold(
      (failure) => emit(OtpErrorState(failure.message)),
      (_) => emit(OtpSentState(phoneNumber: phoneNumber)),
    );
  }

  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(const AuthLoadingState());

    final result = await _verifyOtpUseCase(
      phone: phoneNumber,
      otp: otp,
    );

    result.fold(
      (failure) {
        if (failure.message.contains('expired')) {
          emit(OtpExpiredState(failure.message));
        } else if (failure.message.contains('invalid')) {
          emit(OtpInvalidCodeState(failure.message));
        } else {
          emit(OtpErrorState(failure.message));
        }
      },
      (token) async {
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', phoneNumber);
        await prefsAuth.remove('displayName');
        emit(AuthAuthenticated(email: phoneNumber));
      },
    );
  }

  // ════════════════════════════════════════════════════════════════
  // Complete Profile
  // ════════════════════════════════════════════════════════════════

  Future<void> completeProfile({
    required String phoneNumber,
    required String name,
    required String email,
    required String gender,
    String? address,
    String? bio,
  }) async {
    emit(const AuthLoadingState());

    final result = await _completeProfileUseCase(
      phone: phoneNumber,
      name: name,
      email: email,
      gender: gender,
      address: address,
      bio: bio,
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (user) async {
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', user.email);
        if (user.name != null) {
          await prefsAuth.setString('displayName', user.name!);
        }
        emit(AuthAuthenticated(email: user.email, displayName: user.name));
      },
    );
  }

  // ════════════════════════════════════════════════════════════════
  // Password Reset
  // ════════════════════════════════════════════════════════════════

  Future<void> requestPasswordReset({
    required String email,
  }) async {
    emit(const AuthLoadingState());

    final result = await _requestPasswordResetUseCase(email: email);

    result.fold(
      (failure) => emit(PasswordResetErrorState(failure.message)),
      (_) => emit(ResetCodeSentState(email: email)),
    );
  }

  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    emit(const AuthLoadingState());

    final result = await _verifyResetCodeUseCase(
      email: email,
      code: code,
    );

    result.fold(
      (failure) {
        if (failure.message.contains('expired')) {
          emit(ResetCodeExpiredState(failure.message));
        } else if (failure.message.contains('invalid')) {
          emit(ResetCodeInvalidState(failure.message));
        } else {
          emit(PasswordResetErrorState(failure.message));
        }
      },
      (_) async {
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', email);
        await prefsAuth.remove('displayName');
        emit(AuthAuthenticated(email: email));
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(const AuthLoadingState());

    final result = await _resetPasswordUseCase(
      email: email,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(PasswordResetErrorState(failure.message)),
      (_) async {
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', email);
      },
    );
  }

  

  // ════════════════════════════════════════════════════════════════
  // Social Sign In
  // ════════════════════════════════════════════════════════════════

  Future<void> signInWithGoogle({bool rememberMe = false}) async {
    emit(const AuthLoadingState());

    final result = await _signInWithGoogleUseCase();

    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (token) async {
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', 'user@gmail.com');
        await prefsAuth.remove('displayName');
        emit(AuthAuthenticated(email: 'user@gmail.com', displayName: null));
      },
    );
  }

  Future<void> signInWithApple({bool rememberMe = false}) async {
    emit(const AuthLoadingState());

    final result = await _signInWithAppleUseCase();

    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (token) async {
        final prefsAuth = await SharedPreferences.getInstance();
        await prefsAuth.setString('email', 'user@icloud.com');
        await prefsAuth.remove('displayName');
        emit(AuthAuthenticated(email: 'user@icloud.com', displayName: null));
      },
    );
  }
}
