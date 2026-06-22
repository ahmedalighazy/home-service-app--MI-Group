import '../models/app_config_model.dart';

abstract class SplashLocalDataSource {
  Future<AppConfigModel> getAppConfig();
  Future<void> setFirstLaunch(bool isFirstLaunch);
  Future<void> setLoginStatus(bool isLoggedIn, String? userId);
}
