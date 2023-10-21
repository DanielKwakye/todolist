import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nanoid/nanoid.dart';
import 'package:todolist/core/utils/constants.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';

class TasksRepository {

  //! This adds new task to DB
  Future<Either<String, TaskModel>> addTask(TaskModel task) async {

    try{

      final box = await Hive.openBox<TaskModel>(kTasksDb);
      box.put(task.id, task);
      await box.close();

      return Right(task);

    }catch(e){
      return  Left(e.toString());
    }


  }

  //! This updates existing task in DB
  Future<Either<String, void>> updateTask(TaskModel updatedTask) async {

    try{

      final box = await Hive.openBox<TaskModel>(kTasksDb);
      box.put(updatedTask.id, updatedTask);
      return const Right(null);

    }catch(e){
      return  Left(e.toString());
    }

  }

  //! This removes existing task from DB
  Future<Either<String, void>> removeTask(TaskModel task) async {
    try{

      final box = await Hive.openBox<TaskModel>(kTasksDb);
      box.delete(task.id);
      box.close();
      return const Right(null);

    }catch(e){
      return  Left(e.toString());
    }
  }

  //! This fetches existing tasks from DB
  Future<Either<String, List<TaskModel>>> fetchTasks() async {
    try{

      final box = await Hive.openBox<TaskModel>(kTasksDb);
      final tasks = box.values.toList();
      box.close();
      return  Right(tasks);

    }catch(e){
      return  Left(e.toString());
    }
  }

}