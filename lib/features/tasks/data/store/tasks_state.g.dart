// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TasksStateCWProxy {
  TasksState status(TasksStatus status);

  TasksState message(String message);

  TasksState tasks(List<TaskModel> tasks);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TasksState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TasksState(...).copyWith(id: 12, name: "My name")
  /// ````
  TasksState call({
    TasksStatus? status,
    String? message,
    List<TaskModel>? tasks,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTasksState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTasksState.copyWith.fieldName(...)`
class _$TasksStateCWProxyImpl implements _$TasksStateCWProxy {
  const _$TasksStateCWProxyImpl(this._value);

  final TasksState _value;

  @override
  TasksState status(TasksStatus status) => this(status: status);

  @override
  TasksState message(String message) => this(message: message);

  @override
  TasksState tasks(List<TaskModel> tasks) => this(tasks: tasks);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TasksState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TasksState(...).copyWith(id: 12, name: "My name")
  /// ````
  TasksState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? tasks = const $CopyWithPlaceholder(),
  }) {
    return TasksState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TasksStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      tasks: tasks == const $CopyWithPlaceholder() || tasks == null
          ? _value.tasks
          // ignore: cast_nullable_to_non_nullable
          : tasks as List<TaskModel>,
    );
  }
}

extension $TasksStateCopyWith on TasksState {
  /// Returns a callable class that can be used as follows: `instanceOfTasksState.copyWith(...)` or like so:`instanceOfTasksState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TasksStateCWProxy get copyWith => _$TasksStateCWProxyImpl(this);
}
