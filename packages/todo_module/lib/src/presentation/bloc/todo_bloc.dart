
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_module/src/domain/entities/todo.dart';
import 'package:todo_module/src/domain/usecases/add_todo.dart';
import 'package:todo_module/src/domain/usecases/get_todos.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  const AddTodoEvent(this.title);
  @override
  List<Object> get props => [title];
}

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  const TodoLoaded(this.todos);
  @override
  List<Object> get props => [todos];
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    final todos = getTodos();
    emit(TodoLoaded(todos));
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    addTodo(event.title);
    final todos = getTodos();
    emit(TodoLoaded(todos));
  }
}