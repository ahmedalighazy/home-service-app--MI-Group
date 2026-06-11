import '../entities/app_config_entity.dart';
import '../repositories/splash_repository.dart';

class GetAppConfigUseCase {
  final SplashRepository repository;

  GetAppConfigUseCase(this.repository);

  Future<AppConfigEntity> call() {
    return repository.getAppConfig();
  }
}
