import '../models/message_model.dart';

abstract class SettingLocalDataSource {
  Future<void> cacheMessages(List<MessageModel> messages);
  Future<List<MessageModel>?> getCachedMessages();
  Future<void> cacheNotificationSettings(bool enabled);
  Future<bool?> getCachedNotificationSettings();
  Future<void> cacheLanguage(String language);
  Future<String?> getCachedLanguage();
  Future<void> clearCache();
}
