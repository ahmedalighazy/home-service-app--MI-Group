class TimeSlotEntity {
  final String startTime;
  final String endTime;

  const TimeSlotEntity({required this.startTime, required this.endTime});

  static const List<TimeSlotEntity> catalogue = [
    TimeSlotEntity(startTime: '08:00', endTime: '09:00'),
    TimeSlotEntity(startTime: '09:00', endTime: '10:00'),
    TimeSlotEntity(startTime: '10:00', endTime: '11:00'),
    TimeSlotEntity(startTime: '11:00', endTime: '12:00'),
    TimeSlotEntity(startTime: '12:00', endTime: '13:00'),
    TimeSlotEntity(startTime: '13:00', endTime: '14:00'),
    TimeSlotEntity(startTime: '14:00', endTime: '15:00'),
    TimeSlotEntity(startTime: '15:00', endTime: '16:00'),
  ];
}
