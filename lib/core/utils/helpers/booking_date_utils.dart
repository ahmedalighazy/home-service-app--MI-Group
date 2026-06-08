const Map<int, String> kArabicDayNames = {
  6: 'السبت',
  7: 'الأحد',
  1: 'الاثنين',
  2: 'الثلاثاء',
  3: 'الأربعاء',
  4: 'الخميس',
  5: 'الجمعة',
};

List<DateTime> buildWeekStartingSaturday() {
  final today = DateTime.now();
  final daysSinceSaturday = switch (today.weekday) {
    6 => 0,
    7 => 1,
    int weekday => weekday + 1,
  };
  final saturday = today.subtract(Duration(days: daysSinceSaturday));

  return List.generate(7, (index) => saturday.add(Duration(days: index)));
}
