import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/reusable_widgets/app_bar.dart';
import 'package:to_do_list/reusable_widgets/drawer.dart';
import 'package:to_do_list/reusable_widgets/new_task_widget.dart';
import 'package:to_do_list/services/navigation_service.dart';

import '../constants.dart';
import '../models/task.dart';
import '../models/widget_view.dart';

part 'task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key, required this.screenType}) : super(key: key);
  final Screen screenType;

  @override
  State<TaskScreen> createState() => _TaskScreenController();
}

class _TaskScreenController extends State<TaskScreen> {
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    switch (widget.screenType) {
      case Screen.task:
        return _TaskView(this);
      case Screen.today:
        return _TodayView(this);
      case Screen.upcoming:
        return _UpcomingView(this);
      default:
        return _TaskView(this);
    }
  }

  void _handleFabPressed() async {
    Task? result = await showDialog(
        context: context,
        builder: (context) {
          return const NewTaskWidget();
        });
    if (result != null) {
      await saveTask(result);
      setState(() {});
    }
  }

  void _handleCheckboxPressed(Task task, newValue) {
    {
      setState(() {
        task.isComplete = newValue!;
      });
    }
  }

  void _handleOnDismissed(Task task, int index) async {
    var taskBox = await Hive.openBox(hiveTaskBox);
    await taskBox.delete(task.key);
    setState(() {
      taskList.removeAt(index);
    });
  }

  Future<int> saveTask(Task task) async {
    var taskBox = await Hive.openBox(hiveTaskBox);
    return await taskBox.add(task);
  }

  Future<void> _getTasks({DateTime? dateTo}) async {
    var taskBox = await Hive.openBox(hiveTaskBox);
    Iterable tasksFromHive;
    if (dateTo != null) {
      tasksFromHive =
          taskBox.values.where((element) => element.date.isBefore(dateTo));
    } else {
      tasksFromHive = taskBox.values;
    }
    taskList = List<Task>.from(tasksFromHive);
    taskList.sort(
      (a, b) => a.date.compareTo(b.date),
    );
  }
}

enum Screen { task, today, upcoming }
