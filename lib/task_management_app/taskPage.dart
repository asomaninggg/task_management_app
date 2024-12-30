import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beginner/task_management_app/blocs/task_bloc.dart';
import 'package:beginner/task_management_app/blocs/task_state.dart';
import 'package:beginner/task_management_app/blocs/task_event.dart';

class taskPage extends StatelessWidget {
  const taskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Available'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Text(
              "Today's Tasks:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // BlocBuilder to listen to changes in TaskState and update the UI
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  final tasks = state.tasks;

                  if (tasks.isEmpty) {
                    return const Text(
                        'No tasks available.'); // Handle empty list
                  }

                  return ListView.builder(
                    shrinkWrap: true, // Limit the height to the content
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        leading: const Icon(Icons.work),
                        title: Text(task.title),
                        subtitle: Text(task.description),
                        trailing: IconButton(
                          // Add the delete button
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            print(
                                'Delete button pressed for task ID: ${task.id}'); // Debug statement
                            context
                                .read<TaskBloc>()
                                .add(DeleteTask(task.id)); // To delete event
                          },
                        ),
                      );
                    },
                  );
                } else if (state is TaskError) {
                  // Handle error state if you have one
                  return const Center(
                      child: Text('An error occurred while loading tasks.'));
                } else {
                  // Catch-all case for any other state
                  return const Center(
                      child: Text('Unknown state encountered.'));
                }
              },
            ),

            const Divider(),
            const Text(
              "Events:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('No events today', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
