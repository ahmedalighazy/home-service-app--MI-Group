import 'package:dio/dio.dart';
import 'package:home_service_app/features/home/data/models/category_model.dart';
import 'package:home_service_app/features/home/data/models/home_data_model.dart';
import 'package:home_service_app/features/notification/data/models/notification_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:home_service_app/features/auth/data/models/response/login_response_model.dart';
import 'package:home_service_app/features/profile/data/models/profile_responses.dart';
import 'package:home_service_app/features/profile/data/models/update_responses.dart';
import 'package:home_service_app/features/profile/data/models/change_password_responses.dart';
import '../../features/auth/data/models/request/auth_request.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

// # dart
// dart pub run build_runner build

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ========================= Auth =========================

  // Login endpoints
  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  @POST(ApiConstants.loginPhone)
  Future<LoginResponseModel> loginPhone(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.loginEmail)
  Future<LoginResponseModel> loginEmail(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.google)
  Future<LoginResponseModel> google(@Body() Map<String, dynamic> body);

  // Registration flow
  @POST(ApiConstants.register)
  Future<String> register(@Body() RegisterRequest request);

  @POST(ApiConstants.registerEmail)
  Future<String> registerEmail(@Body() RegisterEmailRequest request);

  @POST(ApiConstants.registerVerifyOtp)
  Future<String> registerVerifyOtp(@Body() RegisterVerifyOtpRequest request);

  @POST(ApiConstants.registerComplete)
  Future<String> registerComplete(@Body() CompleteProfileRequest request);

  // OTP resend
  @POST(ApiConstants.resendOtp)
  Future<String> resendOtp(@Body() ResendOtpRequest request);

  // Account activation
  @POST(ApiConstants.activate)
  Future<String> activate(@Body() ActivateAccountRequest request);

  // Password reset flow
  @POST(ApiConstants.forgotPassword)
  Future<String> forgotPassword(@Body() ForgotPasswordRequest request);

  @POST(ApiConstants.verifyResetOtp)
  Future<String> verifyResetOtp(@Body() VerifyResetOtpRequest request);

  @POST(ApiConstants.resetPassword)
  Future<String> resetPassword(@Body() ResetPasswordRequest request);

  @POST(ApiConstants.passwordVerifyOtp)
  Future<String> passwordVerifyOtp(@Body() VerifyOtpRequest request);

  @POST(ApiConstants.passwordReset)
  Future<String> passwordReset(@Body() PasswordResetRequest request);

  @POST(ApiConstants.passwordRequestReset)
  Future<String> passwordRequestReset(
    @Body() PasswordRequestResetRequest request,
  );

  // Refresh & Logout
  @POST(ApiConstants.refresh)
  Future<LoginResponseModel> refresh(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.logout)
  Future<String> logout(@Body() Map<String, dynamic> body);

  // ======================== Profile =======================

  @GET(ApiConstants.profile)
  Future<ProfileResponses> getProfile();

  @PUT(ApiConstants.updateProfile)
  Future<UpdateResponses> updateProfile(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.changePassword)
  Future<void> changePassword(@Body() ChangePasswordResponses body);

  @DELETE(ApiConstants.profile)
  Future<void> deleteAccount();

  // ======================== Home ========================

  @GET(ApiConstants.home)
  Future<HomeDataModel> getHome();

  @GET(ApiConstants.categories)
  Future<List<CategoryModel>> getCategories();

  // ======================== Notification ========================

  @GET(ApiConstants.notifications)
  Future<List<NotificationModel>> getNotifications();

  @PATCH(ApiConstants.notificationRead)
  Future<void> markNotificationAsRead(@Path('id') String id);
}
