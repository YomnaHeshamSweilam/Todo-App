import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/component/component.dart';
import 'package:todolist/component/cubit/cubit.dart';
import 'package:todolist/component/cubit/states.dart';


class TodoList extends StatelessWidget
{


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  TodoList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (BuildContext context , AppStates state){
            if( state is AppInsertToDataBase){
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppStates state)
          {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.orange[400],
                title: Text(
                    cubit.titles[cubit.currentIndex]),
              ),
              body: ConditionalBuilder(
                builder: (context) =>cubit.screens[cubit.currentIndex],
                condition: state is !AppGetDataLoadingFromDataBase,
                fallback: (context) => const Center(child: CircularProgressIndicator(),) ,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.orange[400],
                onPressed: () {
                  if (cubit.isBottomSheetShown)
                  {
                    if (formKey.currentState!.validate())
                    {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      );
                    }
                  } else
                  {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(
                          20.0,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                validator: ( value) {
                                  if (value!.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text('Task Title'),
                                  prefixIcon:Icon(Icons.title),
                                ),

                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                             TextFormField(
                                controller: timeController,
                                keyboardType: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                    print(value.format(context));
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'time must not be empty';
                                  }

                                  return null;
                                },
                               decoration: const InputDecoration(
                                 label: Text('Task Time'),
                                 prefixIcon: Icon(Icons.watch_later_outlined),
                               ),

                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: dateController,
                                keyboardType: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-05-03'),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!).toString();
                                  });
                                },
                                validator: ( value) {
                                  if (value!.isEmpty) {
                                    return 'date must not be empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today),
                                  label: Text('Task Date'),
                                ),


                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                    )
                        .closed
                        .then((value)
                    {
                      cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit,
                      );
                    });
                    cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add,
                    );
                  }
                },
                child: Icon(
                  cubit.fabIcon,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.orange.shade400,
                  currentIndex:  cubit.currentIndex,
                  onTap: (index)
                  {
                   cubit.changeIndex(index);
                  },
                  elevation: 0.0,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu_outlined), label: 'Tasks' ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done_outline), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined), label: 'Archive'),
                  ]),
            );
          },
      )
    );
  }


}



