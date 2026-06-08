/// Represents a bookable time window shown in the time-slot grid.
class TimeSlot {
  final String startTime; // e.g. "08:00"
  final String endTime; // e.g. "09:00"

  const TimeSlot({required this.startTime, required this.endTime});

  /// Catalogue of available slots for the service booking flow.
  static const List<TimeSlot> catalogue = [
    TimeSlot(startTime: '08:00', endTime: '09:00'),
    TimeSlot(startTime: '09:00', endTime: '10:00'),
    TimeSlot(startTime: '10:00', endTime: '11:00'),
    TimeSlot(startTime: '11:00', endTime: '12:00'),
    TimeSlot(startTime: '12:00', endTime: '13:00'),
    TimeSlot(startTime: '13:00', endTime: '14:00'),
    TimeSlot(startTime: '14:00', endTime: '15:00'),
    TimeSlot(startTime: '15:00', endTime: '16:00'),
  ];
}

