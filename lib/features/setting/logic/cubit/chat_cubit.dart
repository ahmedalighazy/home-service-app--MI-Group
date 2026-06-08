import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message_model.dart';

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
    // Simulate loading messages
    Future.delayed(const Duration(seconds: 1), () {
      emit(
        ChatLoaded([
          MessageModel(
            id: '1',
            content: 'مرحباً أحمد، كيف يمكننا مساعدتك اليوم؟',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
            sender: MessageSender.support,
          ),
          MessageModel(
            id: '2',
            content: 'أريد الاستفسار عن موعد الزيارة القادم.',
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
            sender: MessageSender.user,
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
        sender: MessageSender.user,
        isSent: true,
      );
      emit(ChatLoaded(List.from(messages)..add(newMessage)));

      // Simulate support response
      Future.delayed(const Duration(seconds: 2), () {
        if (state is ChatLoaded) {
          final currentMessages = (state as ChatLoaded).messages;
          final response = MessageModel(
            id: DateTime.now().toString(),
            content: 'سأقوم بالتحقق من ذلك فوراً.',
            timestamp: DateTime.now(),
            sender: MessageSender.support,
          );
          emit(ChatLoaded(List.from(currentMessages)..add(response)));
        }
      });
    }
  }
}
