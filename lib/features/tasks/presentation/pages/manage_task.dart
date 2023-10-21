import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/mix/form_mixin.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/core/utils/functions.dart';
import 'package:todolist/core/utils/theme.dart';
import 'package:todolist/features/auth/data/store/auth_cubit.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_border_widget.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_text_field_widget.dart';
import 'package:todolist/features/tasks/data/store/tasks_cubit.dart';
import 'package:todolist/features/tasks/data/store/tasks_enums.dart';
import 'package:todolist/features/tasks/data/store/tasks_state.dart';

class ManageTaskPage extends StatefulWidget {

  final TaskModel? task;
  const ManageTaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<ManageTaskPage> createState() => _ManageTaskPageState();
}

class _ManageTaskPageState extends State<ManageTaskPage> with FormMixin {

  final TextEditingController nameController = TextEditingController();
  late TasksCubit tasksCubit;

  @override
  void initState() {
    nameController.text = widget.task?.name ?? '';
    tasksCubit = context.read<TasksCubit>();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  /// Methods
  void handleSubmit(BuildContext ctx) {

      // check if field is not empty
      if(!validateAndSaveOnSubmit(ctx)){
        return;
      }

      final name = nameController.text;

      // Update task
      if(widget.task != null){
        tasksCubit.updateTask(widget.task!, name);
        return;
      }

      // add new task
      tasksCubit.addNewTask(name);
  }

  void handleTaskResponse(BuildContext context, TasksState state){
    if(state.status == TasksStatus.addNewTaskSuccessful){
      context.showSnackBar("Task added to list");
      pop(context);
    }

    if(state.status == TasksStatus.updateTaskSuccessful){
      context.showSnackBar("Task updated");
      pop(context);
    }

    if(state.status == TasksStatus.addNewTaskFailed){
      context.showSnackBar(state.message);
    }

    if(state.status == TasksStatus.updateTaskFailed){
      context.showSnackBar(state.message);
    }

  }


  /// UI layer --------
  ///
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
          title: Text("${widget.task == null ? 'Add' : 'Update'} list item", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
          bottom: const PreferredSize(preferredSize: Size.fromHeight(1), child: CustomBorderWidget(),),
          actions: [
            BlocConsumer<TasksCubit, TasksState>(
              listener: handleTaskResponse,
              builder: (context, state) {
                if(state.status == TasksStatus.addNewTaskInProgress || state.status == TasksStatus.updateTaskInProgress) {
                  return IconButton(onPressed: () => {}, icon: const CircularProgressIndicator(color: kAppBlue, strokeWidth: 2,));
                }
                return TextButton(onPressed: () => handleSubmit(context), child:
                Text("Save", style: theme.textTheme.bodyMedium?.copyWith(color: kAppBlue, fontWeight: FontWeight.bold),
                )
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
             children: [
               CustomTextFieldWidget(
                 label: 'Task name',
                 controller: nameController,
                 inputType: TextInputType.emailAddress,
                 validator: isRequired,
                 placeHolder: 'Enter task name here',
               ),
             ],
          ),
        ),
      ),
    );
  }


}
