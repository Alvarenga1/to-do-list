import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../models/task.dart';
import '../services/navigation_service.dart';

class NewTaskWidget extends ConsumerStatefulWidget {
  const NewTaskWidget({super.key});

  @override
  ConsumerState<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends ConsumerState<NewTaskWidget> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late Task newTask;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Title",
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "Description",
                  filled: true,
                  border: OutlineInputBorder(),
                ),
                minLines: 1,
                maxLines: 3,
              ),
              SizedBox(
                child: Card(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  elevation: 2,
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      dateFormat.format(_selectedDate),
                    ),
                    onTap: () async {
                      _selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          ) ??
                          DateTime.now();
                      setState(() {});
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => NavigationService.pop(),
                      child: const Text("Cancel")),
                  SizedBox(
                    width: 8,
                  ),
                  FilledButton(
                      onPressed: () => NavigationService.pop(Task(
                          title: _titleController.text,
                          description: _descriptionController.text.isNotEmpty
                              ? _descriptionController.text
                              : null,
                          date: DateTime(_selectedDate.year,
                              _selectedDate.month, _selectedDate.day))),
                      child: const Text("Save"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
