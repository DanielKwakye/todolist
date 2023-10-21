// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskModelCWProxy {
  TaskModel id(String? id);

  TaskModel name(String? name);

  TaskModel completed(bool completed);

  TaskModel createdAt(DateTime? createdAt);

  TaskModel updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskModel(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskModel call({
    String? id,
    String? name,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskModel.copyWith.fieldName(...)`
class _$TaskModelCWProxyImpl implements _$TaskModelCWProxy {
  const _$TaskModelCWProxyImpl(this._value);

  final TaskModel _value;

  @override
  TaskModel id(String? id) => this(id: id);

  @override
  TaskModel name(String? name) => this(name: name);

  @override
  TaskModel completed(bool completed) => this(completed: completed);

  @override
  TaskModel createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  TaskModel updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskModel(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return TaskModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      completed: completed == const $CopyWithPlaceholder() || completed == null
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $TaskModelCopyWith on TaskModel {
  /// Returns a callable class that can be used as follows: `instanceOfTaskModel.copyWith(...)` or like so:`instanceOfTaskModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaskModelCWProxy get copyWith => _$TaskModelCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 1;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      completed: fields[2] as bool,
      createdAt: fields[3] as DateTime?,
      updatedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
