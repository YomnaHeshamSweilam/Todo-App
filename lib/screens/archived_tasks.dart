import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/component.dart';
import '../component/cubit/cubit.dart';
import '../component/cubit/states.dart';
class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context , state ){
        var tasks =AppCubit.get(context).archiveTasks;
        return tasksBuilder(tasks: tasks);
      } ,
    );
  }
}
