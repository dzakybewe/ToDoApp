class ToDo{
  String taskName;
  bool isFinished;

  ToDo({
    required this.taskName,
    this.isFinished = false
  });

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
    taskName: json["taskName"],
    isFinished: json["isFinished"],
  );

  Map<String, dynamic> toJson() => {
    "taskName": taskName,
    "isFinished": isFinished,
  };
}

List toDoList = [
  ['Click the ADD button to add a new task', false],
  ['Swipe the task to delete it', false],
  ['Check the box to mark task as DONE', true],
];