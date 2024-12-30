import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beginner/task_management_app/task.dart';
import 'task_event.dart';
import 'task_state.dart';

// Define the TaskBloc class that extends Bloc<Event, State>
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<Task> _tasks = []; // Stores the list of tasks

  TaskBloc() : super(TaskInitial()) {
    // Defining event handlers using the "on" method

    // Handling AddTask event
    on<AddTask>((event, emit) {
      _tasks.add(event.task); // Adding the new task to the list
      emit(TaskLoaded(_tasks)); // Emit the new state with updated tasks
    });

    // Handling UpdateTask event
    on<UpdateTask>((event, emit) {
      _tasks = _tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      emit(TaskLoaded(_tasks)); // Emit the updated list
    });

    // Handling DeleteTask event
    on<DeleteTask>((event, emit) {
      print('Before deletion: $_tasks'); // Log before deletion
      _tasks.removeWhere((task) => task.id == event.taskId);
      print('Remaining tasks after deletion: $_tasks'); // Debug statement
      emit(TaskLoaded(_tasks)); // Emit the updated list after deletion
    });

    // Handling LoadTasks event
    on<LoadTasks>((event, emit) {
      emit(TaskLoading()); // Show loading state

      // Simulate task loading (you can replace this with actual data fetching)
      Future.delayed(const Duration(seconds: 1), () {
        if (_tasks.isEmpty) {
          // Populate initial tasks if the list is empty
          _tasks = [
            Task(
              id: DateTime.now().toString(),
              title: "Sample Task",
              time: DateTime.now(),
              description: "This is a sample task",
            ),
          ];
        }
        emit(TaskLoaded(_tasks)); // Emit the loaded tasks
      });
    });

    // Handling EditTask event
    on<EditTask>((event, emit) {
      final updatedTasks = (state as TaskLoaded).tasks.map((task) {
        return task.id == event.updatedTask.id ? event.updatedTask : task;
      }).toList();
      emit(TaskLoaded(updatedTasks));
    });
  }
}
