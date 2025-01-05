// task_model.dart

class Task {
  Task({
    required this.title,
    required this.description,
    required this.deadline,
    required this.isCompleted,
  });

  String title;
  String description;
  DateTime deadline;
  bool isCompleted;
}
