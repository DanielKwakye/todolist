import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/app/routing/route_constants.dart';
import 'package:todolist/core/utils/constants.dart';
import 'package:todolist/core/utils/functions.dart';
import 'package:todolist/core/utils/theme.dart';
import 'package:todolist/features/auth/data/store/auth_cubit.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/store/tasks_cubit.dart';
import 'package:todolist/features/tasks/data/store/tasks_enums.dart';
import 'package:todolist/features/tasks/data/store/tasks_state.dart';
import 'package:todolist/features/tasks/presentation/widgets/empty_task_widget.dart';
import 'package:todolist/features/tasks/presentation/widgets/logout_button_widget.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_border_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  late AuthCubit authCubit;
  late TasksCubit tasksCubit;

  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    tasksCubit = context.read<TasksCubit>();
    tasksCubit.fetchAllTask();
    super.initState();
  }

  /// Methods layer
  ///
  void handleLogout() {
    authCubit.logout();
  }

  void handleThemeChanges(BuildContext context) {
    if(theme(context).brightness == Brightness.dark) {
      AdaptiveTheme.of(context).setLight();
      setSystemUIOverlays(Brightness.light);
    }else{
      AdaptiveTheme.of(context).setDark();
      setSystemUIOverlays(Brightness.dark);
    }
  }
  
  void handleAddTaskPressed(BuildContext context) {
    context.push(manageTaskPage);
  }
  
  void handleEditTaskPressed(BuildContext context, TaskModel task) {
    context.push(manageTaskPage, extra: task);
  }

  void handleToggleTaskCompleted(TaskModel task, bool completed) {
    tasksCubit.markTaskAsCompleted(task, completed);
  }



  /// UI layer ==========
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final screenWidth = width(context);

    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
        title: Text("Todo list", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(1), child: CustomBorderWidget(),),
        actions:  [
          const LogoutButtonWidget(),
           IconButton(onPressed: () => handleThemeChanges(context), icon: Icon(theme.brightness == Brightness.dark ? FeatherIcons.sun : FeatherIcons.moon, size: 18,))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => handleAddTaskPressed(context),child: const Icon(FeatherIcons.plus),),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {

          /// Ui when fetching tasks
          if(state.status == TasksStatus.fetchTasksInProgress) {
            return const Center(
              child: CircularProgressIndicator(color: kAppBlue, strokeWidth: 2,),
            );
          }

          /// Show empty task
          if(state.tasks.isEmpty) {
            return const EmptyTaskWidget();
          }


          return AnimationLimiter(
            child: ListView.separated(
              separatorBuilder: (_, __) => const CustomBorderWidget(),
              itemCount: state.tasks.length,
              itemBuilder: (BuildContext context, int i) {

                final task = state.tasks[i];
                final key = ValueKey(task.id);

                return AnimationConfiguration.staggeredList(
                  key: key,
                  position: i,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Dismissible(
                        key: key,
                        direction: DismissDirection.endToStart,

                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            // Your deletion logic goes here.
                            tasksCubit.deleteTask(task);
                          }
                        },
                        background: const ColoredBox(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          leading: Icon(FeatherIcons.edit, color: theme.colorScheme.onBackground, size: 18,),
                          minLeadingWidth: 0,
                          title: Text(
                            task.name ?? '',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                decoration: task.completed ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          onTap: () => context.push(manageTaskPage, extra: task),
                          subtitle: Text("Added ${getTimeAgo(task.createdAt!)}", style: theme.textTheme.bodySmall,),
                          trailing: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0), // Adjust the value to control the corner radius
                                color: task.completed ? kAppBlue : Colors.transparent,
                                border:  task.completed ? null
                                    : Border.all(color: theme.colorScheme.onBackground)
                            ),
                            width: 25,
                            height: 25,
                            child: Checkbox(
                              value: task.completed ,
                              onChanged: (v) => handleToggleTaskCompleted(task, v ?? false),
                              fillColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(width: 1.0, color: Colors.transparent),
                              ),
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0), // Adjust the value to match the parent container's corner radius
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );

        },)
      );
  }
}
