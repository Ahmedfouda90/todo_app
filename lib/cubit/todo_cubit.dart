import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/screens/archive_screen.dart';
import 'package:todo_app/screens/done_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';

import 'todo_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isBottomSheet = false;
  IconData? floatingIcon = Icons.edit;

  void changeBottomSheetState(
      {@required bool? isShow, @required IconData? icon}) {
    isBottomSheet = isShow!;
    floatingIcon = icon;
    emit(AppChangeBottomBarStates());
  }

  List<Widget> screens = const [TasksScreen(), DoneScreen(), ArchiveScreen()];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomBarStates());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void creatDatabase() {
    openDatabase('todo.dp', // name of project
        version: 1,
        // oncreated method called just once , if it created (this about project name )he ignore it ifelse he crete it,
        onCreate: (database, version) {
      print('database created ');

      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('table created ');
      }).catchError((error) {
        print('error when creating table  !${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('data opened');
    }).then((value) {
      database = value;
      emit(AppCreatDatabaseState());
    });
  }

  Future insertToDatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  }) async {
    try {
      await database!.transaction((txn) async {
        var value = await txn
            .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date", "$time", "new")',
          // ['first task', '030320', '892', 'new'],
        )
            .then((value) {
          print('$value inserted successfully');
          emit(AppInsertDatabaseState());
          getDataFromDatabase(database);
        });
      });
    } catch (error) {
      print('Error when inserting the record: $error');
    }
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
        print(element['status']);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    @required String? status,
    @required int? id,
  }) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }
  void deleteData({
    @required int? id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?',
        [ id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
