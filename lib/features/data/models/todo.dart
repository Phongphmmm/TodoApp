class TodoModel {
  final String id;
  final String title;
  final bool completed;

  TodoModel({required this.id, required this.title, required this.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'completed': completed};
  }
}
