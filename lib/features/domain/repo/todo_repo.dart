import 'package:todo_app/features/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<TodoEntity> createTodo(TodoEntity todo);
  Future<TodoEntity> updateTodo(String id, TodoEntity todo);
  Future<void> deleteTodo(String id);
}
