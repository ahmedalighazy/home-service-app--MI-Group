import '../entities/subscription_entity.dart';
import '../repositories/profile_repository.dart';

class GetSubscriptionsUseCase {
  final ProfileRepository repository;

  GetSubscriptionsUseCase(this.repository);

  Future<List<SubscriptionEntity>> call() {
    return repository.getSubscriptions();
  }
}
