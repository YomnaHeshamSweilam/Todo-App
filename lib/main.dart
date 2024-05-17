import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todolist/component/bloc_observer.dart';
import 'package:todolist/screens/screen1.dart';

void main() {
  Bloc.observer =MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}


