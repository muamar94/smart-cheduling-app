// event_model.dart

class Event {
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;

  Event({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });
}
