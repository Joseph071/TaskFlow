import 'dart:convert';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
    required this.userId,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
  final int userId;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String,
      isCompleted: json['isCompleted'] as bool,
      userId: json['userId'] as int,
    );
  }
}

void main() {
  const response = '''
  {
    "id": 7,
    "title": "Preparar exposición",
    "description": "Organizar diapositivas y practicar",
    "priority": "Alta",
    "isCompleted": false,
    "userId": 1
  }
  ''';

  final json = jsonDecode(response) as Map<String, dynamic>;
  final task = Task.fromJson(json);
  print('Tarea ${task.id}: ${task.title}');
  print('Prioridad: ${task.priority}');
  print('Pendiente: ${!task.isCompleted}');
}