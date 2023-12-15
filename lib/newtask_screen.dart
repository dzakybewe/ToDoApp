import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/widgets/save_delete_button.dart';

class NewTaskScreen extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  NewTaskScreen({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(),
                    hintText: 'Add a new task',
                    hintStyle: TextStyle(color: Colors.grey,)
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SaveDeleteButton(text: 'Save', onPressed: onSave),
                  SaveDeleteButton(text: 'Cancel', onPressed: onCancel),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}