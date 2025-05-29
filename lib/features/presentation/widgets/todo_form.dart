import 'package:flutter/material.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/presentation/bloc/todo/todo_bloc.dart';
import 'package:todo_app/features/presentation/bloc/todo/todo_event.dart';

class TodoForm extends StatelessWidget {
  final TodoEntity? todo;
  final TodoBloc bloc;

  TodoForm({this.todo, required this.bloc});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      _titleController.text = todo!.title;
    }

    return AlertDialog(
      title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'Title'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newTodo = TodoEntity(
                id: todo?.id ?? '',
                title: _titleController.text,
                completed: todo?.completed ?? false,
              );
              if (todo == null) {
                bloc.add(AddTodo(newTodo));
              } else {
                bloc.add(UpdateTodoEvent(todo!.id, newTodo));
              }
              Navigator.pop(context);
            }
          },
          child: Text(todo == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
