import 'package:todo_module/src/domain/entities/todo.dart';

abstract class TodoRepository {
  List<Todo> getTodos();
  void addTodo(String title);
}