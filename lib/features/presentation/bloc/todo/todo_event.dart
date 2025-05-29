import 'package:equatable/equatable.dart';
import 'package:todo_app/features/domain/entities/todo.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final TodoEntity todo;

  AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final String id;
  final TodoEntity todo;

  UpdateTodoEvent(this.id, this.todo);

  @override
  List<Object> get props => [id, todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);

  @override
  List<Object> get props => [id];
}
