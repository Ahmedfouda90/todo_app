import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/const/consts.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_states.dart';
import 'package:todo_app/custom_widgets/custm_form_field.dart';
import 'package:todo_app/screens/archive_screen.dart';
import 'package:todo_app/screens/done_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/sqflite_methods/sqflite_methods.dart';
import 'package:todo_app/widgets_body/bottom_bar_body.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Database? database;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

/*
  void initState() {
    super.initState();
    SqfliteMethods.creatDatabase();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (BuildContext context, AppStates states) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              centerTitle: true, title: Text(cubit.titles[cubit.currentIndex])),
          body: /*tasks.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : */
          cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      date: dateController.text,
                      time: timeController.text,
                      title: titleController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(
                              20.0,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20.0, left: 20),
                                    child: CustomFormField(
                                      suffixPressed: (){},
                                      controller: titleController,
                                      onTap: () {},
                                      labelText: 'add title',
                                      prefix: const Icon(Icons.title),
                                      textInputType: TextInputType.text,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomFormField(
                                      controller: dateController,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-12-03'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                          print(
                                              DateFormat.yMMMd().format(value));
                                        });
                                      },
                                      labelText: 'date time',
                                      prefix:
                                          const Icon(Icons.calendar_view_day),
                                      suffixPressed: () {},
                                      textInputType: TextInputType.datetime,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'date must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomFormField(
                                      controller: timeController,
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                          print(value.format(context));
                                          print('ljblfeekjb');
                                        });
                                      },
                                      labelText: 'task time',
                                      prefix: const Icon(
                                          Icons.watch_later_outlined),
                                      suffixPressed: () {},
                                      textInputType: TextInputType.datetime,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                    /* setState(() {
                      floatingIcon = Icons.edit;
                    });*/
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                  /*  setState(() {
                    floatingIcon = Icons.add;
                  });*/
                }
              },
              child: Icon(cubit.floatingIcon)),
          bottomNavigationBar: BottomBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      }),
    );
  }
}
