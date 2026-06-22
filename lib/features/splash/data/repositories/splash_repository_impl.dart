import '../../domain/entities/app_config_entity.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_datasource.dart';
import '../models/app_config_model.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource localDataSource;

  SplashRepositoryImpl({required this.localDataSource});

  @override
  Future<AppConfigEntity> getAppConfig() async {
    final model = await localDataSource.getAppConfig();
    return _toAppConfigEntity(model);
  }

  @override
  Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await localDataSource.setFirstLaunch(isFirstLaunch);
  }

  AppConfigEntity _toAppConfigEntity(AppConfigModel model) {
    return AppConfigEntity(
      isFirstLaunch: model.isFirstLaunch,
      isLoggedIn: model.isLoggedIn,
      userId: model.userId,
    );
  }
}
