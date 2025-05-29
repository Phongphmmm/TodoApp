import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repo/todo_repo.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<List<TodoEntity>> call() async {
    return await repository.getTodos();
  }
}
