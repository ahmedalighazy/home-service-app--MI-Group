import '../entities/app_config_entity.dart';

abstract class SplashRepository {
  Future<AppConfigEntity> getAppConfig();
  Future<void> setFirstLaunch(bool isFirstLaunch);
}
