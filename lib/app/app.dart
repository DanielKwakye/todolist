import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/app/routing/routes.dart';
import 'package:todolist/core/utils/constants.dart';
import 'package:todolist/core/utils/injector.dart';
import 'package:todolist/core/utils/theme.dart';
import 'package:todolist/features/auth/data/repositories/auth_repository.dart';
import 'package:todolist/features/auth/data/store/auth_cubit.dart';
import 'package:todolist/features/tasks/data/repositories/tasks_broadcast_repository.dart';
import 'package:todolist/features/tasks/data/repositories/tasks_repository.dart';
import 'package:todolist/features/tasks/data/store/tasks_cubit.dart';


class App extends StatelessWidget {

  final AdaptiveThemeMode? savedThemeMode;

  const App({this.savedThemeMode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(

      light: lightTheme(context),
      dark: darkTheme(context),
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (ThemeData theme, ThemeData darkTheme) {

        final authRepository = AuthRepository();
        final taskRepository = TasksRepository();
        final taskBroadcastRepository = sl<TasksBroadcastRepository>();


        return MultiBlocProvider(
            providers: [
              /// Register global providers
              BlocProvider(create: (context) => AuthCubit(authRepository)),
              BlocProvider(create: (context) => TasksCubit(tasksRepository: taskRepository, tasksBroadcastRepository: taskBroadcastRepository)),
            ],
            child: MaterialApp.router(
              title: kCompanyName,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              theme: theme,
              routerConfig: router,
              builder: (ctx, widget) {
                setSystemUIOverlays(theme.brightness);
                return  widget ?? const SizedBox.shrink();
              },
            )
        );
      },
    );
  }
}




