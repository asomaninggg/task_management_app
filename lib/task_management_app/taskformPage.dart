import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beginner/task_management_app/blocs/task_bloc.dart';
import 'package:beginner/task_management_app/blocs/task_event.dart';
import 'package:beginner/task_management_app/task.dart'; // Import the Task model

class TaskformPage extends StatefulWidget {
  final Task? task; // Optional parameter to hold the existing task

  const TaskformPage({Key? key, this.task})
      : super(key: key); // Update constructor

  @override
  State<TaskformPage> createState() => _TaskformPageState();
}

class _TaskformPageState extends State<TaskformPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if editing an existing task
    if (widget.task != null) {
      _title = widget.task!.title; // Pre-fill title if editing
      _description =
          widget.task!.description; // Pre-fill description if editing
      _timeOfDay = TimeOfDay.fromDateTime(widget.task!.time); // Pre-fill time
    }
  }

  // Show time picker
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _timeOfDay, // Use the selected time
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value; // Update selected time
        });
      }
    });
  }

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final task = Task(
        id: widget.task?.id ??
            DateTime.now().toString(), // Use existing ID or generate a new one
        title: _title,
        time:
            DateTime.now(), // Adjust this to reflect the selected time properly
        description: _description,
      );

      if (widget.task != null) {
        // If editing, dispatch UpdateTask event
        context.read<TaskBloc>().add(UpdateTask(task));
      } else {
        // If adding a new task, dispatch AddTask event
        context.read<TaskBloc>().add(AddTask(task));
      }

      // After submission, clear the form and navigate back
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Task Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!; // Save the title
                },
                initialValue: widget.task?.title, // Pre-fill title if editing
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!; // Save the description
                },
                initialValue:
                    widget.task?.description, // Pre-fill description if editing
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Selected Time: ${_timeOfDay.format(context)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _showTimePicker,
                    child: const Text('SET TIME'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
