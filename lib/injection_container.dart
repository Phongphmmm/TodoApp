import 'package:get_it/get_it.dart';
import 'package:todo_app/features/data/repo/auth_repo_impl.dart';
import 'package:todo_app/features/data/repo/todo_repo_impl.dart';
import 'package:todo_app/features/data/services/api_service.dart';
import 'package:todo_app/features/data/services/storage_service.dart';
import 'package:todo_app/features/domain/repo/auth_repo.dart';
import 'package:todo_app/features/domain/repo/todo_repo.dart';
import 'package:todo_app/features/domain/usecases/auth/login.dart';
import 'package:todo_app/features/domain/usecases/auth/register.dart';
import 'package:todo_app/features/domain/usecases/todos/get_todo.dart';
import 'package:todo_app/features/domain/usecases/todos/create_todo.dart';
import 'package:todo_app/features/domain/usecases/todos/update_todo.dart';
import 'package:todo_app/features/domain/usecases/todos/delete_todo.dart';
import 'package:todo_app/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:todo_app/features/presentation/bloc/todo/todo_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  try {
    // Services
    sl.registerSingletonAsync<StorageService>(() async {
      try {
        final storageService = StorageService();

        return storageService;
      } catch (e) {
        rethrow;
      }
    });

    sl.registerSingletonWithDependencies<ApiService>(() {
      return ApiService(sl.get<StorageService>());
    }, dependsOn: [StorageService]);

    // Repositories
    sl.registerSingletonWithDependencies<AuthRepository>(() {
      return AuthRepositoryImpl(sl.get<ApiService>(), sl.get<StorageService>());
    }, dependsOn: [ApiService, StorageService]);

    sl.registerSingletonWithDependencies<TodoRepository>(() {
      return TodoRepositoryImpl(sl.get<ApiService>());
    }, dependsOn: [ApiService]);

    // UseCases
    sl.registerLazySingleton<Login>(() {
      return Login(sl.get<AuthRepository>());
    });

    sl.registerLazySingleton<Register>(() {
      return Register(sl.get<AuthRepository>());
    });

    sl.registerLazySingleton<GetTodos>(() {
      return GetTodos(sl.get<TodoRepository>());
    });

    sl.registerLazySingleton<CreateTodo>(() {
      return CreateTodo(sl.get<TodoRepository>());
    });

    sl.registerLazySingleton<UpdateTodo>(() {
      return UpdateTodo(sl.get<TodoRepository>());
    });

    sl.registerLazySingleton<DeleteTodo>(() {
      return DeleteTodo(sl.get<TodoRepository>());
    });

    // Blocs
    sl.registerFactory<AuthBloc>(() {
      try {
        return AuthBloc(
          login: sl.get<Login>(),
          register: sl.get<Register>(),
          authRepository: sl.get<AuthRepository>(),
        );
      } catch (e) {
        rethrow;
      }
    });

    sl.registerFactory<TodoBloc>(() {
      try {
        return TodoBloc(
          getTodos: sl.get<GetTodos>(),
          createTodo: sl.get<CreateTodo>(),
          updateTodo: sl.get<UpdateTodo>(),
          deleteTodo: sl.get<DeleteTodo>(),
        );
      } catch (e) {
        rethrow;
      }
    });

    try {
      await sl.allReady(timeout: const Duration(seconds: 10));
    } catch (e) {
      throw Exception('Không thể khởi tạo dependencies: $e');
    }
  } catch (e) {
    rethrow;
  }
}
