
class EventData {
  EventData({required this.eventTypeId, required this.duration });

  int eventTypeId = 0;
  Duration duration = const Duration();
}

Map<String, EventData> eventMap = {
  "minha": EventData(eventTypeId: 4, duration: const Duration(minutes: 15))
};
