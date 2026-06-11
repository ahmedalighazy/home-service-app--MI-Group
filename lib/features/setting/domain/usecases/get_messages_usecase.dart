import '../entities/message_entity.dart';
import '../repositories/setting_repository.dart';

class GetMessagesUseCase {
  final SettingRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<MessageEntity>> call() {
    return repository.getMessages();
  }
}
