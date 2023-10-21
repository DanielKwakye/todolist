import 'dart:async';

import 'package:todolist/features/tasks/data/models/task_broadcast_event.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/store/tasks_enums.dart';


class TasksBroadcastRepository {

  final _streamController = StreamController<TaskBroadCastEvent>.broadcast();

  Stream<TaskBroadCastEvent> get stream => _streamController.stream;

  void updateTask({required TaskModel task}) {
    _streamController.sink.add(TaskBroadCastEvent(action: TaskBroadcastAction.update, task: task));
  }

  void addTask({required TaskModel task}) {
    _streamController.sink.add(TaskBroadCastEvent(action: TaskBroadcastAction.add, task: task));
  }

  void removeTask({required TaskModel task}) {
    _streamController.sink.add(TaskBroadCastEvent(action: TaskBroadcastAction.remove, task: task));
  }

}