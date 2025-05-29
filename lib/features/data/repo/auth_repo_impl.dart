import 'package:todo_app/features/domain/entities/user.dart';
import 'package:todo_app/features/domain/repo/auth_repo.dart';

import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;
  final StorageService storageService;

  AuthRepositoryImpl(this.apiService, this.storageService);

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await apiService.register(email, password);
    await storageService.saveToken(user.token);
    return UserEntity(email: user.email, token: user.token);
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await apiService.login(email, password);
    await storageService.saveToken(user.token);
    return UserEntity(email: user.email, token: user.token);
  }

  @override
  Future<void> logout() async {
    await storageService.clearToken();
  }

  @override
  Future<String?> getToken() async {
    return await storageService.getToken();
  }
}
