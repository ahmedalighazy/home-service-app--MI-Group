import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(Map<String, dynamic> profileData) {
    return repository.updateProfile(profileData);
  }
}
