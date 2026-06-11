enum MessageType { text, image }

enum MessageSender { user, support }

class MessageEntity {
  final String id;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final MessageSender sender;
  final bool isSent;

  MessageEntity({
    required this.id,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    required this.sender,
    this.isSent = true,
  });

  MessageEntity copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    MessageType? type,
    MessageSender? sender,
    bool? isSent,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      sender: sender ?? this.sender,
      isSent: isSent ?? this.isSent,
    );
  }
}
