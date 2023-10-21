

import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/store/tasks_enums.dart';

class TaskBroadCastEvent {

  final TaskBroadcastAction action;
  final TaskModel? task;

  const TaskBroadCastEvent({required this.action, this.task});
}