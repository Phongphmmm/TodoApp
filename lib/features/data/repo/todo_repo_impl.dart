import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repo/todo_repo.dart';

import '../models/todo.dart';
import '../services/api_service.dart';

class TodoRepositoryImpl implements TodoRepository {
  final ApiService apiService;

  TodoRepositoryImpl(this.apiService);

  @override
  Future<List<TodoEntity>> getTodos() async {
    final todos = await apiService.getTodos();
    return todos
        .map(
          (todo) => TodoEntity(
            id: todo.id,
            title: todo.title,
            completed: todo.completed,
          ),
        )
        .toList();
  }

  @override
  Future<TodoEntity> createTodo(TodoEntity todo) async {
    final todoModel = TodoModel(
      id: '',
      title: todo.title,
      completed: todo.completed,
    );
    final result = await apiService.createTodo(todoModel);
    return TodoEntity(
      id: result.id,
      title: result.title,
      completed: result.completed,
    );
  }

  @override
  Future<TodoEntity> updateTodo(String id, TodoEntity todo) async {
    final todoModel = TodoModel(
      id: id,
      title: todo.title,
      completed: todo.completed,
    );
    final result = await apiService.updateTodo(id, todoModel);
    return TodoEntity(
      id: result.id,
      title: result.title,
      completed: result.completed,
    );
  }

  @override
  Future<void> deleteTodo(String id) async {
    await apiService.deleteTodo(id);
  }
}
