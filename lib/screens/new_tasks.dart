import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/component/component.dart';

import 'package:todolist/component/cubit/cubit.dart';
import 'package:todolist/component/cubit/states.dart';


class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context , state ){
        var tasks =AppCubit.get(context).newTasks;
        return tasksBuilder(tasks: tasks);
      } ,
    );
  }
}
