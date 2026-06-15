import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/setting_repository.dart';
import '../datasources/setting_remote_datasource.dart';
import '../datasources/setting_local_datasource.dart';
import '../models/message_model.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDataSource remoteDataSource;
  final SettingLocalDataSource localDataSource;

  SettingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> sendMessage(MessageEntity message) async {
    final model = _toMessageModel(message);
    await remoteDataSource.sendMessage(model);
  }

  @override
  Future<List<MessageEntity>> getMessages() async {
    try {
      final messageModels = await remoteDataSource.getMessages();
      await localDataSource.cacheMessages(messageModels);
      return messageModels.map((model) => _toMessageEntity(model)).toList();
    } catch (e) {
      final cached = await localDataSource.getCachedMessages();
      if (cached != null) {
        return cached.map((model) => _toMessageEntity(model)).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> updateNotificationSettings(bool enabled) async {
    await remoteDataSource.updateNotificationSettings(enabled);
    await localDataSource.cacheNotificationSettings(enabled);
  }

  @override
  Future<bool> getNotificationSettings() async {
    try {
      final enabled = await remoteDataSource.getNotificationSettings();
      await localDataSource.cacheNotificationSettings(enabled);
      return enabled;
    } catch (e) {
      final cached = await localDataSource.getCachedNotificationSettings();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  @override
  Future<void> updateLanguage(String language) async {
    await remoteDataSource.updateLanguage(language);
    await localDataSource.cacheLanguage(language);
  }

  @override
  Future<String> getLanguage() async {
    try {
      final language = await remoteDataSource.getLanguage();
      await localDataSource.cacheLanguage(language);
      return language;
    } catch (e) {
      final cached = await localDataSource.getCachedLanguage();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearCache();
  }

  MessageEntity _toMessageEntity(MessageModel model) {
    return MessageEntity(
      id: model.id,
      content: model.content,
      timestamp: model.timestamp,
      type: model.type,
      sender: model.sender,
      isSent: model.isSent,
    );
  }

  MessageModel _toMessageModel(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      content: entity.content,
      timestamp: entity.timestamp,
      type: entity.type,
      sender: entity.sender,
      isSent: entity.isSent,
    );
  }
}
