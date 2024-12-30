import 'package:equatable/equatable.dart';
import 'package:beginner/task_management_app/task.dart';

//defining abstract class for all task events
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

// Event for creating a task
class AddTask extends TaskEvent {
  final Task task; // Pass the task to be added

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

// Event for updating a task
class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

// Event for deleting a task
class DeleteTask extends TaskEvent {
  final String taskId; // We can delete a task by ID

  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}

// Event for loading all tasks (read all)
class LoadTasks extends TaskEvent {
  const LoadTasks();
}

class EditTask extends TaskEvent {
  final Task updatedTask;

  EditTask(this.updatedTask);

  @override
  List<Object> get props => [updatedTask];
}
