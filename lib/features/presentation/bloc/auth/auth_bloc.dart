import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/domain/entities/user.dart';
import 'package:todo_app/features/domain/repo/auth_repo.dart';
import '../../../domain/usecases/auth/login.dart';
import '../../../domain/usecases/auth/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final AuthRepository authRepository;

  AuthBloc({
    required this.login,
    required this.register,
    required this.authRepository,
  }) : super(AuthInitial()) {
    print('AuthBloc initialized');
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print('Handling LoginEvent for ${event.email}');
    try {
      final user = await login(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      print('Login error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print('Handling RegisterEvent for ${event.email}');
    try {
      final user = await register(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      print('Register error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    print('Handling LogoutEvent');
    try {
      await authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      print('Logout error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    print('Checking auth status...');
    try {
      final token = await authRepository.getToken();
      if (token != null) {
        print('Token found: $token');
        emit(AuthAuthenticated(UserEntity(email: '', token: token)));
      } else {
        print('No token found');
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      print('Error checking auth status: $e');
      emit(AuthUnauthenticated());
    }
  }
}
