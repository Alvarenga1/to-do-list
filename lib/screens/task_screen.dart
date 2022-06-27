import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/reusable_widgets/app_bar.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends ConsumerState<TaskScreen> {
  DateTime? _selectedDate;
  static final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  var textProvider = StateProvider((_) => _titleController.text.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    bool value = ref.watch(textProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWrapper(
        title: "To-Do List",
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onChanged: (val) {
                  ref.read(textProvider.notifier).state = val.isNotEmpty;
                },
                autofocus: true,
                decoration: const InputDecoration(hintText: "Title"),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: "Description"),
                minLines: 3,
                maxLines: 5,
              ),
              SizedBox(
                width: 150,
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    _selectedDate?.toString() ?? 'No Date',
                  ),
                  onTap: () async {
                    _selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: value
                ? () {
                    Navigator.of(context).pop(Task(
                        title: _titleController.text,
                        description: _descriptionController.text.isNotEmpty
                            ? _descriptionController.text
                            : null,
                        date: _selectedDate));
                  }
                : null,
            child: const Icon(
              Icons.done,
            ),
          ),
        ),
      ]),
    );
  }
}
