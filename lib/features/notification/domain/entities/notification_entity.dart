import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String title;
  final String description;
  final String time;
  final String group;
  final String iconPath;
  final bool isRead;

  const NotificationEntity({
    required this.title,
    required this.description,
    required this.time,
    required this.group,
    required this.iconPath,
    this.isRead = false,
  });

  NotificationEntity copyWith({
    String? title,
    String? description,
    String? time,
    String? group,
    String? iconPath,
    bool? isRead,
  }) {
    return NotificationEntity(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      group: group ?? this.group,
      iconPath: iconPath ?? this.iconPath,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
    title,
    description,
    time,
    group,
    iconPath,
    isRead,
  ];
}
