import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/auth_state.dart';
import '../../../../core/utils/helpers/cache_helper.dart';
import '../../../../core/utils/l10n/localization_service.dart';
import '../../domain/usecases/complete_profile_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/request_password_reset_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_in_with_apple_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/verify_reset_code_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final CompleteProfileUseCase _completeProfileUseCase;
  final RequestPasswordResetUseCase _requestPasswordResetUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final SignOutUseCase _signOutUseCase;
  final SendOtpUseCase _sendOtpUseCase;

  AuthCubit(
    this._signInUseCase,
    this._verifyOtpUseCase,
    this._completeProfileUseCase,
    this._requestPasswordResetUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithAppleUseCase,
    this._getCurrentUserUseCase,
    this._refreshTokenUseCase,
    this._signOutUseCase,
    this._sendOtpUseCase,
  ) : super(const AuthInitialState());

  /// Reset to initial state — call this when entering a new auth screen
  /// to prevent stale states from triggering unintended navigation
  void resetState() {
    emit(const AuthInitialState());
  }

  Future<void> register({
    required String name,
    required String email,
    String? phone,
    required String password,
  }) async {
    emit(const AuthLoadingState());
    final result = await _completeProfileUseCase(
      phone: phone ?? '',
      name: name,
      email: email,
      gender: 'Male', // Default gender since it is not requested in the UI
    );
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (user) => emit(
        AuthSuccessState(
          action: 'profile_completed',
          data: {'userId': user.id, 'email': user.email, 'name': user.name},
        ),
      ),
    );
  }

  Future<void> sendSmsCode(String phoneNumber) async {
    emit(const AuthLoadingState());
    final result = await _sendOtpUseCase(phone: phoneNumber);
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (_) => emit(OtpSentState(phoneNumber: phoneNumber)),
    );
  }

  Future<void> sendResetCode(String email) async {
    emit(const AuthLoadingState());
    final result = await _requestPasswordResetUseCase(email: email);
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (_) => emit(ResetCodeSentState(email: email)),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(const AuthLoadingState());
    final result = await _resetPasswordUseCase(
      email: email,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(PasswordResetErrorState(failure.message)),
      (_) => emit(
        AuthSuccessState(action: 'password_reset', data: {'email': email}),
      ),
    );
  }

  Future<void> loginWithPhone(String phoneNumber) async {
    emit(const AuthLoadingState());
    final result = await _sendOtpUseCase(phone: phoneNumber);
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (_) => emit(OtpSentState(phoneNumber: phoneNumber)),
    );
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    emit(const AuthLoadingState());

    final result = await _signInUseCase(
      identifier: identifier,
      password: password,
    );

    result.fold((failure) => emit(AuthErrorState(failure.message)), (
      loginResponse,
    ) async {
      await CacheHelper.saveData(key: 'token', value: loginResponse.token);

      print("Saved Token => ${CacheHelper.getData(key: 'token')}");

      await CacheHelper.saveData(
        key: 'refreshToken',
        value: loginResponse.refreshToken,
      );

      emit(
        AuthSuccessState(
          action: 'sign_in',
          data: {
            'token': loginResponse.token,
            'refreshToken': loginResponse.refreshToken,
            'id': loginResponse.id,
            'name': loginResponse.name,
            'role': loginResponse.role,
            'pending': loginResponse.pending,
            'email': loginResponse.email,
          },
        ),
      );
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthLoadingState());
    final result = await _signInWithGoogleUseCase(
      idToken: 'mock_google_id_token',
    );
    result.fold(
      (failure) => emit(
        AuthErrorState(
          LocalizationService.instance.translate('googleSignInFailed'),
        ),
      ),
      (token) => emit(
        AuthSuccessState(
          action: 'google_sign_in',
          data: {
            'email': 'user@gmail.com',
            'displayName': 'Google User',
            'token': token.accessToken,
          },
        ),
      ),
    );
  }

  Future<void> signInWithApple() async {
    emit(const AuthLoadingState());
    final result = await _signInWithAppleUseCase(
      identityToken: 'mock_apple_identity_token',
    );
    result.fold(
      (failure) => emit(
        AuthErrorState(
          LocalizationService.instance.translate('appleSignInFailed'),
        ),
      ),
      (token) => emit(
        AuthSuccessState(
          action: 'apple_sign_in',
          data: {
            'email': 'user@icloud.com',
            'displayName': 'Apple User',
            'token': token.accessToken,
          },
        ),
      ),
    );
  }

  Future<void> sendOtp({required String phoneNumber, String? email}) async {
    emit(const AuthLoadingState());
    final result = await _sendOtpUseCase(phone: phoneNumber);
    result.fold(
      (failure) => emit(
        AuthErrorState(LocalizationService.instance.translate('otpSendFailed')),
      ),
      (_) => emit(OtpSentState(phoneNumber: phoneNumber)),
    );
  }

  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(const AuthLoadingState());
    final result = await _verifyOtpUseCase(phone: phoneNumber, otp: otp);
    result.fold(
      (failure) => emit(
        AuthErrorState(
          LocalizationService.instance.translate('otpVerificationFailed'),
        ),
      ),
      (token) => emit(
        AuthSuccessState(
          action: 'otp_verified',
          data: {'phoneNumber': phoneNumber, 'token': token.accessToken},
        ),
      ),
    );
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(const AuthLoadingState());
    final result = await _verifyResetCodeUseCase(email: email, code: code);
    result.fold(
      (failure) => emit(ResetCodeInvalidState(failure.message)),
      (_) => emit(
        AuthSuccessState(
          action: 'reset_code_verified',
          data: {'email': email, 'code': code},
        ),
      ),
    );
  }

  Future<void> signUpWithGoogle() async {
    emit(const AuthLoadingState());
    final result = await _signInWithGoogleUseCase(
      idToken: 'mock_google_id_token',
    );
    result.fold(
      (failure) => emit(
        AuthErrorState(
          LocalizationService.instance.translate('googleSignUpFailed'),
        ),
      ),
      (token) => emit(
        AuthSuccessState(
          action: 'google_sign_up',
          data: {
            'email': 'user@gmail.com',
            'displayName': 'Google User',
            'token': token.accessToken,
          },
        ),
      ),
    );
  }

  Future<void> signUpWithApple() async {
    emit(const AuthLoadingState());
    final result = await _signInWithAppleUseCase(
      identityToken: 'mock_apple_identity_token',
    );
    result.fold(
      (failure) => emit(
        AuthErrorState(
          LocalizationService.instance.translate('appleSignUpFailed'),
        ),
      ),
      (token) => emit(
        AuthSuccessState(
          action: 'apple_sign_up',
          data: {
            'email': 'user@icloud.com',
            'displayName': 'Apple User',
            'token': token.accessToken,
          },
        ),
      ),
    );
  }

  Future<void> loginAsGuest() async {
    emit(const AuthLoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await CacheHelper.saveData(key: 'email', value: 'guest');
      emit(
        const AuthSuccessState(
          action: 'guest_login',
          data: {'email': 'guest', 'displayName': 'Guest'},
        ),
      );
    } catch (e) {
      emit(
        AuthErrorState(
          LocalizationService.instance.translate('guestLoginFailed'),
        ),
      );
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoadingState());
    final result = await _signOutUseCase();
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (_) => emit(const AuthSuccessState(action: 'sign_out', data: {})),
    );
  }

  Future<void> fetchCurrentUser() async {
    emit(const AuthLoadingState());
    final result = await _getCurrentUserUseCase();
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (user) => emit(
        AuthSuccessState(
          action: 'user_fetched',
          data: {'userId': user.id, 'email': user.email, 'name': user.name},
        ),
      ),
    );
  }

  Future<void> refreshToken({required String refreshToken}) async {
    final result = await _refreshTokenUseCase(refreshToken: refreshToken);
    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (token) => emit(
        AuthSuccessState(
          action: 'token_refreshed',
          data: {'token': token.accessToken},
        ),
      ),
    );
  }
}
