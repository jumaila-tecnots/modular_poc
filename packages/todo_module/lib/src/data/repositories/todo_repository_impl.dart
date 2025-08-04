import 'package:todo_module/src/domain/entities/todo.dart';
import 'package:todo_module/src/domain/repositories/todo_repository.dart';
import 'package:todo_module/src/data/datasources/todo_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  List<Todo> getTodos() {
    return dataSource.getTodos().asMap().entries.map((entry) {
      return Todo(id: entry.key, title: entry.value);
    }).toList();
  }

  @override
  void addTodo(String title) {
    dataSource.addTodo(title);
  }
}