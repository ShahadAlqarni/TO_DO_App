import 'package:flutter/material.dart';

import '../colors.dart';
import '../todo_item.dart';
import '../todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundTask = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    //by default equal the current list
    _foundTask = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      //add new task label label
      body: Stack(
        children: [
          //search label
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                //create to-do as item
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All To Do',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //we used the reversed to put a new task at the top
                      for (ToDo task in _foundTask.reversed)
                        ToDoItem(
                          todo: task,
                          onToDoChanged: _handelToDoChange,
                          onDeletItem: _deletToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //add new task label label
          Align(
            alignment: Alignment.bottomCenter,
            //we have 2 items in row
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  //ترتيب الحجم اكثر
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              //create plus button for new task
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    //to add new task
                    _addnewTask(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 60),
                    elevation: 10,
                    backgroundColor: tdBlue,
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

// Mark a task as Done or not
  void _handelToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = (!todo.isDone);
    });
  }

//Delet task
  void _deletToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addnewTask(String toDo) {
    setState(() {
      //uniqe id by usin time
      todoList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    //To clear the text in the field
    _todoController.clear();
  }

  void _runFilter(String enteredText) {
    List<ToDo> results = [];
    if (enteredText.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enteredText.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTask = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
      color: Colors.white, 
      borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        //To activate search with typing
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        //hand size
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          //add image
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/girl.png'),
            ),
          ),
        ],
      ),
    );
  }
}
