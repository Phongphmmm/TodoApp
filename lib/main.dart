import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/presentation/bloc/todo/todo_event.dart';
import 'package:todo_app/injection_container.dart';
import 'package:todo_app/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:todo_app/features/presentation/bloc/auth/auth_event.dart';
import 'package:todo_app/features/presentation/bloc/auth/auth_state.dart';
import 'package:todo_app/features/presentation/bloc/todo/todo_bloc.dart';
import 'package:todo_app/features/presentation/pages/home_page.dart';
import 'package:todo_app/features/presentation/pages/login_page.dart';
import 'package:todo_app/features/presentation/pages/register_page.dart';

void main() async {
  print('Bắt đầu main...');
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await init();
    print('Injection container khởi tạo thành công');
  } catch (e) {
    print('Lỗi khởi tạo injection container: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('Xây dựng MyApp...');
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            print('Tạo AuthBloc...');
            if (!sl.isRegistered<AuthBloc>()) {
              print('AuthBloc chưa được đăng ký trong GetIt');
              throw Exception('AuthBloc chưa được đăng ký');
            }
            final authBloc = sl.get<AuthBloc>();
            authBloc.add(CheckAuthStatus());
            return authBloc;
          },
        ),
        BlocProvider<TodoBloc>(
          create: (context) {
            print('Tạo TodoBloc...');
            if (!sl.isRegistered<TodoBloc>()) {
              print('TodoBloc chưa được đăng ký trong GetIt');
              throw Exception('TodoBloc chưa được đăng ký');
            }
            return sl.get<TodoBloc>();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const AuthWrapper(),
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print('Xây dựng AuthWrapper...');
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print('Trạng thái AuthWrapper: $state');
        if (state is AuthAuthenticated) {
          print('Đã xác thực, lấy todos...');
          context.read<TodoBloc>().add(FetchTodos());
          return HomePage();
        } else if (state is AuthUnauthenticated || state is AuthInitial) {
          print('Chưa xác thực hoặc trạng thái ban đầu, hiển thị LoginPage...');
          return LoginPage();
        }
        print('Trạng thái không xác định, hiển thị loading...');
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
