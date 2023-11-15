import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/const/consts.dart';

class SqfliteMethods {




/*static  Future insertToDatabase({
    @required String? title,
    @required String? time,
    @required String? date,
  }) async {
    return await database!.transaction(
      (txn) {
        var x = txn
            .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")',
        )
            .then((value) {
          print('$value inserted successfully');
        }).catchError((error) {
          print('Error When Inserting New Record ${error.toString()}');
          return null;
        });

        return x;
      },
    );
  }*/
}
