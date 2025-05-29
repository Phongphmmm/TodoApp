import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repo/todo_repo.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<TodoEntity> call(String id, TodoEntity todo) async {
    return await repository.updateTodo(id, todo);
  }
}
