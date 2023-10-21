import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/app/routing/page_not_found.dart';
import 'package:todolist/app/routing/route_constants.dart';
import 'package:todolist/features/auth/data/repositories/auth_repository.dart';
import 'package:todolist/features/auth/presentation/pages/login_page.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/presentation/pages/tasks_page.dart';
import 'package:todolist/features/tasks/presentation/pages/manage_task.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');

// GoRouter configuration
final router = GoRouter(

  debugLogDiagnostics: true,
  errorBuilder: (_, __) {
    return const PageNotFound();
  },
  navigatorKey: _rootNavigator,
  redirect: (BuildContext context, state) async {
    /// Guest Routes
    final List<String> guestRoutes = [
      logInPage
    ];

    // allow all guest route navigation
    if (guestRoutes.contains(state.matchedLocation)) {
      return null;
    }

    final authRepository = AuthRepository();
    final user = await authRepository.getCurrentUserSession();

    // if user is not logged in --- redirect to login page
    if (user == null) {
      return logInPage;
    }

    // else allow the user to go to the intended route
    return null;
  },
  initialLocation: tasksPage,
  routes: [

    /// Authentication page
    GoRoute(
      path: logInPage,
      pageBuilder: (context, state) => MaterialPage(name: state.path, arguments: state.extra,child: const LoginPage()),
    ),

    // manage task
    GoRoute(
      path: manageTaskPage,
      pageBuilder: (context, state) {
        final TaskModel? task = state.extra as TaskModel?;
        return MaterialPage(name: state.path, arguments: state.extra,child:  ManageTaskPage(task: task,));
      },
    ),


    /// Home page
    GoRoute(
        path: tasksPage,
        pageBuilder: (ctx, state) => MaterialPage(child: const TasksPage(), name: state.path, arguments: state.extra),
    ),
  ],
);



