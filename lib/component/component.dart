import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todolist/component/cubit/cubit.dart';

Widget defaultButton({
  Color background = Colors.blue,
  double width = double.infinity,
  required String text,
  required Function function,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField1({
  required TextEditingController controller,
  required Function validate,
  required TextInputType type,
  required String label,
  required IconData prefix,
  Function? onChanged,
  Function? onTap,
  Function? onSubmit,
  IconData? suffix,
  Function? suffixPressed,
  bool obscureText = false,

}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit!();
      },
      validator: (s) {
        validate;
        return null;
      },
      onChanged: (s) {
        onChanged!();
      },
      onTap: () {
        onTap!();
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  suffixPressed;
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget buildTask(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDateBase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              child: Center(child: Text('${model['time']}')),
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).checkIcon = Icons.check_box;
                AppCubit.get(context)
                    .updateDate(status: 'done', id: model['id']);
              },
              icon:  Icon(AppCubit.get(context).checkIcon),
              color: Colors.green,
            ),
            const SizedBox(
              width: 18,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDate(status: 'archive', id: model['id']);
              },
              icon: const Icon(Icons.archive_outlined),
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
        condition: tasks.isNotEmpty,
        builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildTask(tasks[index], context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
            itemCount: tasks.length),
        fallback: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.menu,
              size: 90,
              color: Colors.grey,),
              Text('No tasks Here , Organize your work and add some',
              style: TextStyle(fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold),)
            ],
          ),
        ));
