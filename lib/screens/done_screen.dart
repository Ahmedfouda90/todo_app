import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../cubit/todo_states.dart';
import '../custom_widgets/task_items.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tasks = AppCubit.get(context).doneTasks;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext contrxt, AppStates state) {},
      builder: (BuildContext contrxt, AppStates state) {
        tasks=AppCubit.get(context).doneTasks;
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
            itemBuilder: (context, index) => TaskItems(tasks[index],context),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 2,
              color: Colors.red,
            ),
            itemCount: tasks.length);
      },
    );  }
}
