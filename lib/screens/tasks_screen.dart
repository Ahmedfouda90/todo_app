import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_states.dart';
import 'package:todo_app/custom_widgets/custm_form_field.dart';
import 'package:todo_app/custom_widgets/task_items.dart';

import '../const/consts.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tasks = AppCubit.get(context).newTasks;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext contrxt, AppStates state) {},
      builder: (BuildContext contrxt, AppStates state) {
        tasks = AppCubit.get(context).newTasks;
        return tasks.length == 0
            ? Center(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100,
                    color: Colors.green,
                  ),
                  Text('No Tasks Yet, Please Add Some Tasks',style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold,
                  ),)
                ],
              ),
            )
            : ListView.separated(
                itemBuilder: (context, index) =>
                    TaskItems(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.red,
                    ),
                itemCount: tasks.length);
      },
    )

        // TaskItems(

        ;
  }
}
