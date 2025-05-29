import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';
import '../models/user.dart';
import 'storage_service.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.100:3000/api';
  final StorageService storageService;

  ApiService(this.storageService);

  Future<UserModel> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<TodoModel>> getTodos() async {
    final token = await storageService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/todos'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => TodoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<TodoModel> createTodo(TodoModel todo) async {
    final token = await storageService.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode == 201) {
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<TodoModel> updateTodo(String id, TodoModel todo) async {
    final token = await storageService.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode == 200) {
      return TodoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final token = await storageService.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
