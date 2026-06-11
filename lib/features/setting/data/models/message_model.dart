import '../../domain/entities/message_entity.dart';

class MessageModel {
  final String id;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final MessageSender sender;
  final bool isSent;

  MessageModel({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.sender,
    required this.isSent,
  });
}
