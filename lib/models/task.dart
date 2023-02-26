import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  bool isComplete;

  Task(
      {required this.title,
      this.description,
      required this.date,
      this.isComplete = false});
}
