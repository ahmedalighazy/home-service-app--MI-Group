import '../models/message_model.dart';

abstract class SettingRemoteDataSource {
  Future<void> sendMessage(MessageModel message);
  Future<List<MessageModel>> getMessages();
  Future<void> updateNotificationSettings(bool enabled);
  Future<bool> getNotificationSettings();
  Future<void> updateLanguage(String language);
  Future<String> getLanguage();
  Future<void> logout();
}
