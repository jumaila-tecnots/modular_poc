library todo_module;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:module_manager/module_manager.dart';
import 'package:todo_module/src/presentation/bloc/todo_bloc.dart';
import 'package:todo_module/src/presentation/screens/todo_screen.dart';
import 'package:todo_module/src/data/datasources/todo_datasource.dart';
import 'package:todo_module/src/data/repositories/todo_repository_impl.dart';
import 'package:todo_module/src/domain/repositories/todo_repository.dart';
import 'package:todo_module/src/domain/usecases/add_todo.dart';
import 'package:todo_module/src/domain/usecases/get_todos.dart';

export 'src/presentation/screens/todo_screen.dart';

class TodoModule implements Module {
  @override
  void registerDependencies(GetIt locator) {
    locator.registerLazySingleton<TodoDataSource>(() => TodoDataSourceImpl());
    locator.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(locator()));
    locator.registerLazySingleton(() => GetTodos(locator()));
    locator.registerLazySingleton(() => AddTodo(locator()));
    locator.registerFactory(() => TodoBloc(
      getTodos: locator(),
      addTodo: locator(),
    ));
  }

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/todo': (context) => const TodoScreen(),
    };
  }
}

