import '../../domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final Map<String, dynamic>? recipient;
  final String title;
  final String body;
  final String? imageUrl;
  final String? dataJson;
  final DateTime createdAt;
  final String type;
  final bool read;

  const NotificationModel({
    required this.id,
    this.recipient,
    required this.title,
    required this.body,
    this.imageUrl,
    this.dataJson,
    required this.createdAt,
    required this.type,
    required this.read,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      recipient: json['recipient'] as Map<String, dynamic>?,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      imageUrl: json['imageUrl'],
      dataJson: json['dataJson'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      type: json['type'] ?? '',
      read: json['read'] ?? false,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      imageUrl: imageUrl,
      createdAt: createdAt,
      type: type,
      isRead: read,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient': recipient,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'dataJson': dataJson,
      'createdAt': createdAt.toIso8601String(),
      'type': type,
      'read': read,
    };
  }
}
