class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final String? group;
  final String? description;
  final String? time;
  final String? iconPath;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.group,
    this.description,
    this.time,
    this.iconPath,
  });

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? isRead,
    String? group,
    String? description,
    String? time,
    String? iconPath,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      group: group ?? this.group,
      description: description ?? this.description,
      time: time ?? this.time,
      iconPath: iconPath ?? this.iconPath,
    );
  }
}
