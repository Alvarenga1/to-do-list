class Task {
  String title;
  String? description;
  DateTime? date;
  bool isDone;
  Task({required this.title, this.description, this.date, this.isDone = false});
}
