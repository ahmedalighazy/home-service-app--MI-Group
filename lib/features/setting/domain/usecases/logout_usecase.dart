import '../repositories/setting_repository.dart';

class LogoutUseCase {
  final SettingRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
