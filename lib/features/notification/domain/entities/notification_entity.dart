import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final DateTime createdAt;
  final String type;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    required this.createdAt,
    required this.type,
    required this.isRead,
  });

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    String? imageUrl,
    DateTime? createdAt,
    String? type,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    imageUrl,
    createdAt,
    type,
    isRead,
  ];
}
