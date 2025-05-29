import 'package:todo_app/features/domain/entities/user.dart';
import 'package:todo_app/features/domain/repo/auth_repo.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
