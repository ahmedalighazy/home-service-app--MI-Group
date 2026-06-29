import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:home_service_app/features/auth/data/models/request/login_request_model.dart';
import 'package:home_service_app/features/auth/data/models/response/login_response_model.dart';
import 'package:home_service_app/features/auth/data/models/verify_reset_otp.dart';
import 'package:home_service_app/features/auth/data/models/reset_password_responses.dart';
import 'package:home_service_app/features/auth/data/models/resend_otp_responses.dart';
import 'package:home_service_app/features/auth/data/models/register_responses.dart';
import 'package:home_service_app/features/auth/data/models/register_verify_otp_responses.dart';
import 'package:home_service_app/features/auth/data/models/register_email_responses.dart';
import 'package:home_service_app/features/auth/data/models/complete_responses.dart';
import 'package:home_service_app/features/auth/data/models/request_reset_responses.dart';
import 'package:home_service_app/features/auth/data/models/verify_otp_responses.dart';
import 'package:home_service_app/features/auth/data/models/reset_responses.dart';
import 'package:home_service_app/features/auth/data/models/forget_password_responses.dart';
import 'package:home_service_app/features/profile/data/models/profile_model.dart';

import 'api_constants.dart';

part 'api_service.g.dart';

// # dart
// dart pub run build_runner build

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ========================= Auth =========================

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  @POST(ApiConstants.verifyResetOtp)
  Future<String> verifyResetOtp(@Body() VerifyResetOtp request);

  @POST(ApiConstants.resetPassword)
  Future<String> resetPassword(@Body() ResetPasswordResponses request);

  @POST(ApiConstants.resendOtp)
  Future<String> resendOtp(@Body() ResendOtpResponses request);

  @POST(ApiConstants.register)
  Future<String> register(@Body() RegisterResponses request);

  @POST(ApiConstants.registerVerifyOtp)
  Future<String> registerVerifyOtp(@Body() RegisterVerifyOtpResponses request);

  @POST(ApiConstants.registerEmail)
  Future<String> registerEmail(@Body() RegisterEmailResponses request);

  @POST(ApiConstants.registerComplete)
  Future<String> registerComplete(@Body() CompleteResponses request);

  @POST(ApiConstants.refresh)
  Future<LoginResponseModel> refresh(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.passwordVerifyOtp)
  Future<String> passwordVerifyOtp(@Body() VerifyOtpResponses request);

  @POST(ApiConstants.passwordReset)
  Future<String> passwordReset(@Body() ResetResponses request);

  @POST(ApiConstants.passwordRequestReset)
  Future<String> passwordRequestReset(@Body() RequestResetResponses request);

  @POST(ApiConstants.logout)
  Future<String> logout(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.loginPhone)
  Future<LoginResponseModel> loginPhone(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.loginEmail)
  Future<LoginResponseModel> loginEmail(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.google)
  Future<LoginResponseModel> google(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.forgotPassword)
  Future<String> forgotPassword(@Body() ForgetPasswordResponses request);

  @POST(ApiConstants.activate)
  Future<String> activate(@Body() VerifyOtpResponses request);

  // ======================== Profile =======================

  @GET(ApiConstants.profile)
  Future<ProfileModel> getProfile();
}

