import 'package:todo_app/features/domain/repo/todo_repo.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(String id) async {
    await repository.deleteTodo(id);
  }
}
