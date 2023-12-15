import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/main_screen.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDoApp',
      theme: ThemeData(),
      home: const MainScreen(),
    );
  }
}
