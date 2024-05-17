
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/component/cubit/states.dart';
import 'package:todolist/screens/archived_tasks.dart';
import 'package:todolist/screens/new_tasks.dart';

import '../../screens/done_tasks.dart';




class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];


  void changeIndex(int index)
  {
    currentIndex =index;
    emit(ChangeBottomNavBarState());
  }


   late Database database;
  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> archiveTasks = [];

  void createDatabase()  {
      openDatabase('Todo.db', version: 1,
        onCreate: (database, version)  {
          print('Database Created');
           database
              .execute(
              'CREATE table tasks(id INTEGER PRIMARY KEY ,title TEXT, date TEXT , time TEXT , status TEXT)')
              .then((value) {
            print('Table Created');
          }).catchError((error) {
            print('Error while creating table ${error.toString()}');
          });
        },
          onOpen: (database) {
          getFromDatabase(database);
          print('Database Opened');
        }).then((value)
      {
          database =value;
          emit(AppCreateDataBase());
      });
  }

   insertToDatabase(
      {required String title,
        required String time,
        required String date}) async {
     await database.transaction((txn)  async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title ,date ,time,status) VALUES("$title","$date","$time","New")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(AppInsertToDataBase());
        getFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });
      return null;
    });
  }

  void getFromDatabase(database)
   {
     newTasks =[];
     doneTasks = [];
     archiveTasks =[];
     emit(AppGetDataLoadingFromDataBase());
      database.rawQuery('SELECT* FROM tasks').then((value)
      {
        value.forEach((element)
        {
          if(element['status'] == 'New') {
            newTasks.add(element);
          } else if(element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archiveTasks.add(element);
          }
        });

        emit(AppGetDataFromDataBase());
      });

  }


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
  required bool isShow,
  required IconData icon ,
})
{
  isBottomSheetShown = isShow;
  fabIcon = icon;
  emit(ChangeBottomSheetState());
}

IconData checkIcon = Icons.check_box_outline_blank_outlined;
void changeCheckBox({
    required IconData icon,
}){
  checkIcon = icon ;
  emit(ChangeCheckBox());
}


void updateDate({
    required String status,
    required int id
}) async {
   database.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ?',
      ['$status' , id ]).then((value) {
        getFromDatabase(database);
        emit(UpdateDataBase());

   });
}


  void deleteDateBase({
    required int id
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDataFromDataBase());

    });
  }
}