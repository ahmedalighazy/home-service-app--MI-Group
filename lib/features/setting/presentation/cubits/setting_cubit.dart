import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/repositories/setting_repository.dart';
import '../states/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final LogoutUseCase logoutUseCase;
  final SettingRepository settingRepository;

  SettingCubit({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
    required this.logoutUseCase,
    required this.settingRepository,
  }) : super(SettingInitial());

  Future<void> loadSettings() async {
    emit(SettingLoading());
    try {
      final notificationsEnabled = await settingRepository.getNotificationSettings();
      final language = await settingRepository.getLanguage();
      emit(SettingLoaded(
        notificationsEnabled: notificationsEnabled,
        language: language,
      ));
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }

  Future<void> updateNotifications(bool enabled) async {
    try {
      await settingRepository.updateNotificationSettings(enabled);
      await loadSettings();
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }

  Future<void> updateLanguage(String language) async {
    try {
      await settingRepository.updateLanguage(language);
      await loadSettings();
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }

  Future<void> loadMessages() async {
    emit(MessagesLoading());
    try {
      final messages = await getMessagesUseCase();
      emit(MessagesLoaded(messages));
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }

  Future<void> sendMessage(MessageEntity message) async {
    try {
      await sendMessageUseCase(message);
      emit(MessageSent());
      await loadMessages();
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(SettingLoading());
    try {
      await logoutUseCase();
      emit(LogoutSuccess());
    } catch (e) {
      emit(SettingError(e.toString()));
    }
  }
}
