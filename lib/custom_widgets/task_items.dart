import 'package:flutter/material.dart';
import 'package:todo_app/cubit/todo_cubit.dart';

/*
class TaskItems extends StatelessWidget {
   TaskItems({Key? key,}) : super(key: key);
  static List<Map> tasks=[];
Map? model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigo,
            radius: 40,
            child: Text(*/ /*'jnkjn'*/ /*
              '${model['time']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Task Title',
                style: TextStyle(color: Colors.black,fontSize: 20),
              ),
              Text(
                '5 may 2025',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}*/

Widget TaskItems(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
        padding: EdgeInsets.all(20),
  
        child: Row(
  
          children: [
  
            CircleAvatar(
  
              backgroundColor: Colors.indigo,
  
              radius: 40,
  
              child: Text(
  
                /*'jnkjn'*/
  
                '${model['time']}',
  
                style: TextStyle(color: Colors.white),
  
              ),
  
            ),
  
            SizedBox(
  
              width: 20,
  
            ),
  
            Expanded(
  
              child: Column(
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                mainAxisSize: MainAxisSize.min,
  
                children: [
  
                  Text(
  
                    '${model['title']}',
  
                    style: TextStyle(color: Colors.black, fontSize: 20),
  
                  ),
  
                  Text(
  
                    '${model['date']}',
  
                    style: TextStyle(color: Colors.grey),
  
                  ),
  
                ],
  
              ),
  
            ),
  
            IconButton(
  
                onPressed: () {
  
                  AppCubit.get(context)
  
                      .updateData(status: 'done', id: model['id']);
  
                  },
  
                icon: Icon(
  
                  Icons.check_box,
  
                  color: Colors.green,
  
                )),
  
            IconButton(onPressed: () {
  
              AppCubit.get(context)
  
                  .updateData(status: 'archive', id: model['id']);
  
            }, icon: Icon(Icons.archive_outlined)),
  
          ],
  
        ),
  
      ),
  onDismissed: (direction){
AppCubit.get(context).deleteData(id: model['id']);
  },
);
