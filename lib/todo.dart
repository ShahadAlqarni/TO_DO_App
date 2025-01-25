class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Dinner', isDone: true),
      ToDo(
          id: '02',
          todoText: 'Work on mobile apps for 2 hour',
          isDone: true),
      ToDo(
        id: '03',
        todoText: 'Team Meeting',
      ),
      ToDo(
        id: '04',
        todoText: 'Work on DevOps for 1 hour',
        isDone: true
      ),
      ToDo(
        id: '05',
        todoText: 'Reviewing Previously Logged Tasks and Executing Them',
      ),
      ToDo(
        id: '06',
        todoText: 'Check Emails',
      ),
    ];
  }
}
