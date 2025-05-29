import 'package:todo_app/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> register(String email, String password);
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<String?> getToken();
}
