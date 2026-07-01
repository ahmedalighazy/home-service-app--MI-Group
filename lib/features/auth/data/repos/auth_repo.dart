import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';

import '../../../../core/utils/helpers/cache_helper.dart';
import '../models/request/auth_request.dart';

import '../models/response/login_response_model.dart';

class AuthRepo {
  final ApiService _apiService;

  static const String _tokenKey = 'token';
  static const String _emailKey = 'email';

  AuthRepo(this._apiService);

  // ─────────────────────────── Login ───────────────────────────

  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    try {
      final response = await _apiService.login(request);
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponseModel>> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _apiService.loginPhone({
        'phone': phone,
        'password': password,
      });
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponseModel>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.loginEmail({
        'email': email,
        'password': password,
      });
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponseModel>> loginWithGoogle({
    required String idToken,
    String? name,
    String? email,
    String? googleId,
    String? profilePicture,
  }) async {
    try {
      final body = {
        'idToken': idToken,
        'name': name,
        'email': email,
        'googleId': googleId,
        'profilePicture': profilePicture,
      }..removeWhere((key, value) => value == null);
      final response = await _apiService.google(body);
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ─────────────────────── Registration ───────────────────────

  /// Register a new user (sends OTP)
  Future<ApiResult<String>> register(RegisterRequest request) async {
    try {
      final response = await _apiService.register(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Send OTP to email for registration
  Future<ApiResult<String>> sendRegistrationOtp(String email) async {
    try {
      final response = await _apiService.registerEmail(
        RegisterEmailRequest(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Verify registration OTP
  Future<ApiResult<String>> verifyRegistrationOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.registerVerifyOtp(
        RegisterVerifyOtpRequest(email: email, otp: otp),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Complete registration after OTP verification
  Future<ApiResult<String>> completeRegistration(
    CompleteProfileRequest request,
  ) async {
    try {
      final response = await _apiService.registerComplete(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Resend OTP
  Future<ApiResult<String>> resendOtp(String email) async {
    try {
      final response = await _apiService.resendOtp(
        ResendOtpRequest(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Activate account (verify OTP)
  Future<ApiResult<String>> activateAccount({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.activate(
        ActivateAccountRequest(email: email, otp: otp),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ────────────────────── Password Reset ──────────────────────

  Future<ApiResult<String>> forgotPassword(String email) async {
    try {
      final response = await _apiService.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.verifyResetOtp(
        VerifyResetOtpRequest(email: email, otp: otp),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.resetPassword(
        ResetPasswordRequest(email: email, otp: otp, newPassword: newPassword),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // Alternate password reset endpoints (if needed)
  Future<ApiResult<String>> passwordRequestReset(String email) async {
    try {
      final response = await _apiService.passwordRequestReset(
        PasswordRequestResetRequest(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> passwordVerifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.passwordVerifyOtp(
        VerifyOtpRequest(email: email, otp: otp),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> passwordReset({
    required String email,
    required String otp,
    required String password,
  }) async {
    try {
      final response = await _apiService.passwordReset(
        PasswordResetRequest(email: email, otp: otp, password: password),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ────────────────────── Refresh & Logout ─────────────────────

  Future<ApiResult<LoginResponseModel>> refreshToken() async {
    try {
      final token = CacheHelper.getData(_tokenKey);
      final response = await _apiService.refresh({'refreshToken': token});
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> signOut() async {
    try {
      final token = CacheHelper.getData(_tokenKey) ?? '';
      await _apiService.logout({
        'refreshToken': token,
      }); // أو 'token' حسب الـ API
    } catch (_) {
      // Continue with local clear
    } finally {
      await _clearSession();
    }
    return ApiResult.success('signed_out');
  }

  // ────────────────────── Session / Cache ─────────────────────

  String? get cachedToken => CacheHelper.getData(_tokenKey);
  String? get cachedEmail => CacheHelper.getData(_emailKey);

  Future<void> _cacheSession(LoginResponseModel response) async {
    if (response.token != null) {
      await CacheHelper.saveData(_tokenKey, response.token!);
    }

    if (response.email != null) {
      await CacheHelper.saveData(_emailKey, response.email!);
    }
  }

  Future<void> _clearSession() async {
    await CacheHelper.removeData(_tokenKey);
    await CacheHelper.removeData(_emailKey);
  }
}
