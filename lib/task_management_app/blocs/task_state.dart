import 'package:equatable/equatable.dart';
import 'package:beginner/task_management_app/task.dart';

// Defining abstract class for all task states
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

// Initial state when no tasks are loaded yet
class TaskInitial extends TaskState {}

// State when tasks are being loaded
class TaskLoading extends TaskState {}

// State when tasks are successfully loaded
class TaskLoaded extends TaskState {
  final List<Task> tasks; // List of tasks

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

// State for any errors that occur
class TaskError extends TaskState {
  final String errorMessage;

  const TaskError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
