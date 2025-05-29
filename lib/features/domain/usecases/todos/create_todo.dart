import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repo/todo_repo.dart';

class CreateTodo {
  final TodoRepository repository;

  CreateTodo(this.repository);

  Future<TodoEntity> call(TodoEntity todo) async {
    return await repository.createTodo(todo);
  }
}
