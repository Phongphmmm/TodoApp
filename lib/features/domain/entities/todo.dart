import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final bool completed;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.completed,
  });

  @override
  List<Object> get props => [id, title, completed];
}
