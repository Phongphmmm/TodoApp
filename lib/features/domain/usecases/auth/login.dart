import 'package:todo_app/features/domain/entities/user.dart';
import 'package:todo_app/features/domain/repo/auth_repo.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
