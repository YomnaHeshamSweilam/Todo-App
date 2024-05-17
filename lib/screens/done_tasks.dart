import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/component.dart';
import '../component/cubit/cubit.dart';
import '../component/cubit/states.dart';
class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context , state ){
        var tasks =AppCubit.get(context).doneTasks;
        return tasksBuilder(tasks: tasks);
      } ,
    );
  }
}
