import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/store/tasks_enums.dart';

part 'tasks_state.g.dart';

@CopyWith()
class TasksState extends Equatable {
  final TasksStatus status;
  final String message;
  final List<TaskModel> tasks;

  const TasksState({
    this.status = TasksStatus.initial,
    this.message = '',
    this.tasks = const []
  });

  @override
  List<Object?> get props => [status];

}