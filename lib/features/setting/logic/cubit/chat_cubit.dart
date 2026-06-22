import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageModel> messages;
  ChatLoaded(this.messages);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  void loadMessages() {
    emit(ChatLoading());

    Future.delayed(const Duration(seconds: 1), () {
      emit(
        ChatLoaded([
          MessageModel(
            id: '1',
            content: 'مرحباً أحمد، كيف يمكننا مساعدتك اليوم؟',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
            type: MessageType.text,
            sender: MessageSender.support,
            isSent: true,
          ),
          MessageModel(
            id: '2',
            content: 'أريد الاستفسار عن موعد الزيارة القادم.',
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
            type: MessageType.text,
            sender: MessageSender.user,
            isSent: true,
          ),
        ]),
      );
    });
  }

  void sendMessage(String content) {
    if (state is ChatLoaded) {
      final messages = (state as ChatLoaded).messages;
      final newMessage = MessageModel(
        id: DateTime.now().toString(),
        content: content,
        timestamp: DateTime.now(),
        type: MessageType.text,
        sender: MessageSender.user,
        isSent: true,
      );
      emit(ChatLoaded(List.from(messages)..add(newMessage)));

      Future.delayed(const Duration(seconds: 2), () {
        if (state is ChatLoaded) {
          final currentMessages = (state as ChatLoaded).messages;
          final response = MessageModel(
            id: DateTime.now().toString(),
            content: 'سأقوم بالتحقق من ذلك فوراً.',
            timestamp: DateTime.now(),
            type: MessageType.text,
            sender: MessageSender.support,
            isSent: true,
          );
          emit(ChatLoaded(List.from(currentMessages)..add(response)));
        }
      });
    }
  }
}
