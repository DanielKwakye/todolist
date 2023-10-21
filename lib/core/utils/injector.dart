import 'package:get_it/get_it.dart';
import 'package:todolist/features/tasks/data/repositories/tasks_broadcast_repository.dart';

/// Using Get It as the service locator -> for dependency injections
final sl = GetIt.instance;

/// Initializes all dependencies.
/// We register as lazy singletons to boost performance
/// meaning, Get It would instantiate objects on demand
Future<void> init() async {

  sl.registerLazySingleton(() => TasksBroadcastRepository());


}