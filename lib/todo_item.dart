import 'package:flutter/material.dart';

import '../colors.dart';
import '../todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeletItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeletItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //space bettwen task
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            //on to change
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          //check box
          leading: Icon(
            //when task is done put the check if not will be null
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          //enter text for task
          title: Text(
            //bring task
            todo.todoText!,
            style: TextStyle(
              fontSize: 12,
              color: tdBlack,
              //when task is done go to line through if not will be null
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          //delet icon
          trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: () {
                  //delet task
                  onDeletItem(todo.id);
                },
              )),
        ));
  }
}
