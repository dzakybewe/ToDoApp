import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/newtask_screen.dart';
import 'package:flutter_to_do_app/widgets/dialog_box.dart';
import 'package:flutter_to_do_app/widgets/todo_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_to_do_app/model/todo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ToDo> toDoList = List.empty(growable: true);
  late SharedPreferences sp;

  getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();

    // ToDo(taskName: 'Click the ADD button to add a new task', isFinished: false),
    // ToDo(taskName: 'Swipe the task to delete it', isFinished: false)
    // ToDo(taskName: 'Check the box to mark task as DONE', isFinished: true),
    readDataFromSp();
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  saveDataToSp(){
    List<String> toDoListString = toDoList.map((toDo) => jsonEncode(toDo.toJson())).toList();
    sp.setStringList('myData', toDoListString);
  }

  readDataFromSp(){
    toDoList.add(ToDo(taskName: 'Click the ADD button to add a new task', isFinished: false),);
    toDoList.add(ToDo(taskName: 'Swipe the task to delete it', isFinished: false));
    toDoList.add(ToDo(taskName: 'Check the box to mark task as DONE', isFinished: true));
    List<String>? toDoListString = sp.getStringList('myData');

    if (toDoListString != null) {
      toDoList = toDoListString.map((toDo) => ToDo.fromJson(json.decode(toDo))).toList();
    }

    setState(() {

    });
  }

  // List toDoList = [
  //   ['Click the ADD button to add a new task', false],
  //   ['Swipe the task to delete it', false],
  //   ['Check the box to mark task as DONE', true],
  // ];

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index].isFinished = !toDoList[index].isFinished;
    });
    saveDataToSp();
  }

  void addNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
    );
  }

  void saveNewTask(){
    if (_controller.text.isNotEmpty) {
      setState(() {
        toDoList.add(ToDo(taskName: _controller.text, isFinished: false));
        _controller.clear();
      });
      saveDataToSp();
      Navigator.of(context).pop();
    }
  }

  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
    saveDataToSp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEEEFF5),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFEEEFF5),
          elevation: 0,
          title: const Text(
            'To Do List',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewTaskScreen(
                      controller:_controller,
                      onSave: saveNewTask,
                      onCancel: () => Navigator.of(context).pop()
                    )
                )
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: toDoList[index].taskName,
              isFinished: toDoList[index].isFinished,
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        )
    );
  }
}