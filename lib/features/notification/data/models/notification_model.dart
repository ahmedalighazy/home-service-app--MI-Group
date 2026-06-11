class NotificationModel {
  final String title;
  final String description;
  final String time;
  final String group;
  final String iconPath;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    required this.group,
    required this.iconPath,
    this.isRead = false,
  });

  NotificationModel copyWith({
    String? title,
    String? description,
    String? time,
    String? group,
    String? iconPath,
    bool? isRead,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      group: group ?? this.group,
      iconPath: iconPath ?? this.iconPath,
      isRead: isRead ?? this.isRead,
    );
  }
}
