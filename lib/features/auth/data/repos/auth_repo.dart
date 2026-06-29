import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';
import '../models/complete_responses.dart';
import '../models/forget_password_responses.dart';
import '../models/register_email_responses.dart';
import '../models/register_responses.dart';
import '../models/register_verify_otp_responses.dart';
import '../models/request/login_request_model.dart';
import '../models/request_reset_responses.dart';
import '../models/reset_password_responses.dart';
import '../models/resend_otp_responses.dart';
import '../models/response/login_response_model.dart';
import '../models/verify_reset_otp.dart';

class AuthRepo {
  final ApiService _apiService;
  final SharedPreferences _prefs;

  static const String _tokenKey = 'auth_token';
  static const String _emailKey = 'auth_email';

  AuthRepo(this._apiService, this._prefs);

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

  Future<ApiResult<LoginResponseModel>> loginWithPhone(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _apiService.loginPhone(body);
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponseModel>> loginWithEmail(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _apiService.loginEmail(body);
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponseModel>> loginWithGoogle(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _apiService.google(body);
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ─────────────────────── Registration ───────────────────────

  /// Send OTP to email to start registration
  Future<ApiResult<String>> sendSmsCode(String email) async {
    try {
      final response = await _apiService.registerEmail(
        RegisterEmailResponses(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /// Verify registration OTP
  Future<ApiResult<String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.registerVerifyOtp(
        RegisterVerifyOtpResponses(email: email, otp: otp),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> register(RegisterResponses request) async {
    try {
      final response = await _apiService.register(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> completeProfile(CompleteResponses request) async {
    try {
      final response = await _apiService.registerComplete(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> resendOtp(String email) async {
    try {
      final response = await _apiService.resendOtp(
        ResendOtpResponses(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ────────────────────── Password Reset ──────────────────────

  Future<ApiResult<String>> sendResetCode(String email) async {
    try {
      final response = await _apiService.forgotPassword(
        ForgetPasswordResponses(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> verifyResetCode({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.verifyResetOtp(
        VerifyResetOtp(email: email, otp: otp),
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
        ResetPasswordResponses(
          email: email,
          otp: otp,
          newPassword: newPassword,
        ),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> passwordRequestReset(String email) async {
    try {
      final response = await _apiService.passwordRequestReset(
        RequestResetResponses(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponseModel>> refreshToken(String token) async {
    try {
      final response = await _apiService.refresh({'refreshToken': token});
      await _cacheSession(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  // ────────────────────── Session / Cache ─────────────────────

  Future<ApiResult<String>> signOut() async {
    try {
      final token = _prefs.getString(_tokenKey) ?? '';
      await _apiService.logout({'token': token});
    } catch (_) {
      // Always clear locally even if remote call fails
    } finally {
      await _clearSession();
    }
    return ApiResult.success('signed_out');
  }

  String? get cachedToken => _prefs.getString(_tokenKey);
  String? get cachedEmail => _prefs.getString(_emailKey);

  // ────────────────────────── Helpers ─────────────────────────

  Future<void> _cacheSession(LoginResponseModel response) async {
    if (response.token != null) {
      await _prefs.setString(_tokenKey, response.token!);
    }
    if (response.email != null) {
      await _prefs.setString(_emailKey, response.email!);
    }
  }

  Future<void> _clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_emailKey);
  }
}
