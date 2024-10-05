
class DayAvailability {
  final DateTime day;
  final List<DateTime> timeSlots;

  const DayAvailability({
    required this.day,
    required this.timeSlots,
  });

  factory DayAvailability.fromJson(Map<String, dynamic> map) {
    DateTime day = DateTime.parse(map.entries.first.key);
    List<dynamic> timeSlotObjects = map.entries.first.value;

    var timeSlots = timeSlotObjects.map((tso) {
      var timeSlotObject = tso as Map<String, dynamic>;
      var date = timeSlotObject.entries.first.value;
      return DateTime.parse(date);
    })
    .toList();
    
    return DayAvailability(day: day, timeSlots: timeSlots);
  }
}