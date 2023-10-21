import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@CopyWith()
@HiveType(typeId: 1)
class TaskModel extends Equatable {

  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final DateTime? createdAt;
  @HiveField(4)
  final DateTime? updatedAt;

  const TaskModel({this.id, this.name, this.completed = false, this.createdAt, this.updatedAt});

  @override
  List<Object?> get props => [id, completed];


}