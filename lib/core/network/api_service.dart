import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:home_service_app/features/auth/data/models/request/login_request_model.dart';
import 'package:home_service_app/features/auth/data/models/response/login_response_model.dart';
import 'package:home_service_app/features/profile/data/models/profile_responses.dart';
import 'package:home_service_app/features/profile/data/models/update_responses.dart';
import 'package:home_service_app/features/profile/data/models/change_password_responses.dart';

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

  // ======================== Profile =======================

  @GET(ApiConstants.profile)
  Future<ProfileResponses> getProfile();

  @PUT(ApiConstants.updateProfile)
  Future<UpdateResponses> updateProfile(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.changePassword)
  Future<void> changePassword(@Body() ChangePasswordResponses body);

  @DELETE(ApiConstants.profile)
  Future<void> deleteAccount();
}
