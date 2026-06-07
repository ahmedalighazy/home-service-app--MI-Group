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
