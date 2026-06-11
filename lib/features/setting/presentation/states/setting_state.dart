import '../../domain/entities/message_entity.dart';

abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingLoaded extends SettingState {
  final bool notificationsEnabled;
  final String language;
  
  SettingLoaded({
    required this.notificationsEnabled,
    required this.language,
  });
}

class SettingError extends SettingState {
  final String message;
  
  SettingError(this.message);
}

class MessagesLoading extends SettingState {}

class MessagesLoaded extends SettingState {
  final List<MessageEntity> messages;
  
  MessagesLoaded(this.messages);
}

class MessagesError extends SettingState {
  final String message;
  
  MessagesError(this.message);
}

class MessageSent extends SettingState {}

class LogoutSuccess extends SettingState {}
