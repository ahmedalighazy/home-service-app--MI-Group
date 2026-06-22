import '../entities/message_entity.dart';

abstract class SettingRepository {
  Future<void> sendMessage(MessageEntity message);
  Future<List<MessageEntity>> getMessages();
  Future<void> updateNotificationSettings(bool enabled);
  Future<bool> getNotificationSettings();
  Future<void> updateLanguage(String language);
  Future<String> getLanguage();
  Future<void> logout();
}
