import 'package:todo_module/src/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  void call(String title) {
    repository.addTodo(title);
  }
}