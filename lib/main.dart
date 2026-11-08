import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
}

const demoTasks = [
  Task(
    id: 1,
    title: 'Registrar Laptop Dell',
    description: 'Ingresar datos del cliente y estado físico del equipo',
    priority: 'Alta',
    isCompleted: true, // Completada para tu evidencia
  ),
  Task(
    id: 2,
    title: 'Diagnóstico de hardware',
    description: 'Revisar disco duro y memoria RAM de PC de escritorio',
    priority: 'Alta',
    isCompleted: false,
  ),
  Task(
    id: 3,
    title: 'Generar comprobante PDF',
    description: 'Crear reporte de recepción con firma del cliente',
    priority: 'Media',
    isCompleted: false,
  ),
  Task(
    id: 4,
    title: 'Enviar comprobante por WhatsApp',
    description: 'Compartir el PDF generado al número del cliente',
    priority: 'Media',
    isCompleted: false,
  ),
  Task(
    id: 5,
    title: 'Sincronizar base de datos',
    description: 'Subir registros offline cuando haya conexión',
    priority: 'Baja',
    isCompleted: false,
  ),
];

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TaskListScreen()),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.parse(state.pathParameters['id']!);
        return TaskDetailScreen(taskId: taskId);
      },
    ),
  ],
);

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(task.title),
        subtitle: Text(task.priority + ' · ' + task.description),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return TaskCard(
            task: task,
            onTap: () => context.push('/task/' + task.id.toString()),
          );
        },
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String studentName = 'Escribe tu nombre';

  static const dailyGoal = 5;
  int completedTasks = 0;

  int pendingTasks = 3;

  void _completeTask() {
    if (pendingTasks == 0) {
      return;
    }

    setState(() {
      pendingTasks--;
      if (completedTasks < dailyGoal) {
        completedTasks++;
      }
    });
  }

  void _addTask() {
    setState(() {
      pendingTasks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusMessage = pendingTasks == 0
        ? '¡Excelente! No tienes tareas pendientes.'
        : 'Aún tienes tareas por organizar.';

    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(statusMessage),
            Text('Completadas hoy: $completedTasks de $dailyGoal'),
            const SizedBox(height: 28),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Text('Tareas pendientes: $pendingTasks'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar tarea'),
                ),
                OutlinedButton.icon(
                  onPressed: pendingTasks == 0 ? null : _completeTask,
                  icon: const Icon(Icons.done),
                  label: const Text('Completar una tarea'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    final task = demoTasks.firstWhere((item) => item.id == taskId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de tarea')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text(task.description),
            const SizedBox(height: 16),
            ActionChip(
  avatar: Icon(
    task.priority == 'Alta'
        ? Icons.warning
        : task.priority == 'Media'
            ? Icons.info
            : Icons.low_priority,
    color: task.priority == 'Alta'
        ? Colors.red
        : task.priority == 'Media'
            ? Colors.orange
            : Colors.green,
  ),
  label: Text('Prioridad: ${task.priority}'),
  backgroundColor: task.priority == 'Alta'
      ? Colors.red.shade50
      : task.priority == 'Media'
          ? Colors.orange.shade50
          : Colors.green.shade50,
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          task.priority == 'Alta'
              ? '⚠️ Esta tarea requiere atención inmediata'
              : task.priority == 'Media'
                  ? 'ℹ️ Esta tarea puede esperar un poco'
                  : '✅ Esta tarea no es urgente',
        ),
      ),
    );
  },
),
            const SizedBox(height: 12),
            Text(task.isCompleted ? 'Estado: completada' : 'Estado: pendiente'),
            const Spacer(),
            FilledButton.tonalIcon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al listado'),
            ),
          ],
        ),
      ),
    );
  }
}
