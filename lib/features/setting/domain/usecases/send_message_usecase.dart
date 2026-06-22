import '../entities/message_entity.dart';
import '../repositories/setting_repository.dart';

class SendMessageUseCase {
  final SettingRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(MessageEntity message) {
    return repository.sendMessage(message);
  }
}
