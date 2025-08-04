import 'package:todo_module/src/domain/entities/todo.dart';
import 'package:todo_module/src/domain/repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  List<Todo> call() {
    return repository.getTodos();
  }
}