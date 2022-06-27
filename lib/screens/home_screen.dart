import 'package:flutter/material.dart';
import 'package:to_do_list/reusable_widgets/app_bar.dart';
import 'package:to_do_list/reusable_widgets/drawer.dart';
import 'package:to_do_list/screens/task_screen.dart';

import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWrapper(),
      appBar: const AppBarWrapper(
        title: "To-Do List",
      ),
      body: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: ((context, index) {
            var task = taskList[index];
            return Dismissible(
              key: Key(task.hashCode.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.redAccent,
                alignment: AlignmentDirectional.centerEnd,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) {
                taskList.removeAt(index);
              },
              child: CheckboxListTile(
                title: Text(task.title),
                subtitle:
                    task.description != null ? Text(task.description!) : null,
                value: task.isDone,
                controlAffinity: ListTileControlAffinity.leading,
                tristate: false,
                onChanged: (value) {
                  task.isDone = value!;
                },
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? result = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const TaskScreen()));
          if (result != null) {
            taskList.add(result);
            setState(() {});
          }
        },
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
