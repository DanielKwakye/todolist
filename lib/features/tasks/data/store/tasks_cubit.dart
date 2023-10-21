import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoid/nanoid.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/features/tasks/data/models/task_broadcast_event.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/repositories/tasks_broadcast_repository.dart';
import 'package:todolist/features/tasks/data/store/tasks_enums.dart';
import 'package:todolist/features/tasks/data/store/tasks_state.dart';
import '../repositories/tasks_repository.dart';

class TasksCubit extends Cubit<TasksState> {

  final TasksRepository tasksRepository;
  final TasksBroadcastRepository tasksBroadcastRepository;
  StreamSubscription<TaskBroadCastEvent>? tasksBroadcastRepositoryStreamListener;

  TasksCubit({required this.tasksRepository, required this.tasksBroadcastRepository}) : super(const TasksState()){
    listenFoTasksUpdates();
  }

  /// This method updates tasks globally
  void listenFoTasksUpdates() async {
    await tasksBroadcastRepositoryStreamListener?.cancel();
    tasksBroadcastRepositoryStreamListener = tasksBroadcastRepository.stream.listen((TaskBroadCastEvent taskEvent) {

      final copiedTasks = [...state.tasks];

      // the user can be any user in the system
      if(taskEvent.action == TaskBroadcastAction.add){
        copiedTasks.add(taskEvent.task!);
      }

      else if(taskEvent.action == TaskBroadcastAction.update){
        final taskIndex = copiedTasks.indexWhere((element) => element.id == taskEvent.task!.id);
        if(taskIndex > -1){
          copiedTasks[taskIndex] = taskEvent.task!;
        }

      }

      else if(taskEvent.action == TaskBroadcastAction.remove){
        final copiedTasks = [...state.tasks];
        copiedTasks.removeWhere((element) => element.id == taskEvent.task!.id);
      }

      /// event to refresh UI
      emit(state.copyWith(status: TasksStatus.refreshTasksInProgress));
      emit(state.copyWith(status: TasksStatus.refreshTasksSuccessful, tasks: copiedTasks));






    });
  }

  // Close stream subscriptions when cubit is disposed to avoid any memory leaks
  @override
  Future<void> close() async {
    await tasksBroadcastRepositoryStreamListener?.cancel();
    return super.close();
  }


  /// This method adds new task to the task list
  void addNewTask(String name) async {

    emit(state.copyWith(status: TasksStatus.addNewTaskInProgress));

    final newId = nanoid();
    final task = TaskModel(id: newId, name: name, createdAt: DateTime.now(), updatedAt: DateTime.now());
    tasksBroadcastRepository.addTask(task: task);

    final either = await tasksRepository.addTask(task);

    if(either.isLeft()){
      final l = either.asLeft();
      emit(state.copyWith(status: TasksStatus.addNewTaskFailed, message: l));
      return;
    }

    // add task to list anywhere in the app
    emit(state.copyWith(status: TasksStatus.addNewTaskSuccessful));


  }

  /// This method updates existing task in the list
  void updateTask(TaskModel task, String name)  async {

    emit(state.copyWith(status: TasksStatus.updateTaskInProgress));

    final updatedTask = task.copyWith(
      name: name,
      updatedAt: DateTime.now()
    );
    tasksBroadcastRepository.updateTask(task: updatedTask);
    final either = await tasksRepository.updateTask(updatedTask);
    if(either.isLeft()){
      final l = either.asLeft();
      emit(state.copyWith(status: TasksStatus.updateTaskFailed, message: l));
      return;
    }

    // add task to list anywhere in the app
    emit(state.copyWith(status: TasksStatus.updateTaskSuccessful));


  }

  void markTaskAsCompleted(TaskModel task, bool completed)  async {

    emit(state.copyWith(status: TasksStatus.updateTaskInProgress));

    final updatedTask = task.copyWith(
        completed: completed,
        updatedAt: DateTime.now()
    );
    tasksBroadcastRepository.updateTask(task: updatedTask);
    final either = await tasksRepository.updateTask(updatedTask);
    if(either.isLeft()){
      final l = either.asLeft();
      emit(state.copyWith(status: TasksStatus.updateTaskFailed, message: l));
      return;
    }
    emit(state.copyWith(status: TasksStatus.updateTaskSuccessful));


  }

  /// This method removes a task from the list
  void deleteTask(TaskModel task) async {

    // optimistic update for faster User experience
    emit(state.copyWith(status: TasksStatus.removeTaskInProgress));
    tasksBroadcastRepository.removeTask(task: task);

    final either = await tasksRepository.removeTask(task);
    if(either.isLeft()){
      final l = either.asLeft();
      emit(state.copyWith(status: TasksStatus.removeTaskFailed, message: l));
      return;
    }

    emit(state.copyWith(status: TasksStatus.removeTaskSuccessful));

  }

  /// Load all  existing
  void fetchAllTask() async {
    emit(state.copyWith(status: TasksStatus.fetchTasksInProgress));
    final either = await tasksRepository.fetchTasks();
    if(either.isLeft()){
      final l = either.asLeft();
      emit(state.copyWith(status: TasksStatus.fetchTasksFailed, message: l));
      return;
    }

    final tasks = either.asRight();
    emit(state.copyWith(status: TasksStatus.fetchTasksCompleted,
      tasks: tasks
    ));

  }


}