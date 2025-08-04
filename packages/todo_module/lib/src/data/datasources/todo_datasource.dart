abstract class TodoDataSource {
  List<String> getTodos();
  void addTodo(String todo);
}

class TodoDataSourceImpl implements TodoDataSource {
  final List<String> _todos = [];

  @override
  List<String> getTodos() => _todos;

  @override
  void addTodo(String todo) => _todos.add(todo);
}