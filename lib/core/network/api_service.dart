import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import '../../features/profile/data/models/profile_model.dart';
import 'api_constants.dart';

part 'api_service.g.dart';
// # dart
// dart pub run build_runner build

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  ///auth
  @POST(ApiConstants.login)
  Future<void> login(@Body() dynamic body, @Query('apikey') String apiKey);

  ///home
  @GET(ApiConstants.profile)
  Future<ProfileModel> getProfile(@Body() dynamic body);
}
