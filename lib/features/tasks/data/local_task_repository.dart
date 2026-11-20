import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Registrar Laptop Dell',
      description: 'Ingresar datos del cliente y estado físico del equipo',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Diagnóstico de hardware',
      description: 'Revisar disco duro y memoria RAM de PC de escritorio',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Generar comprobante PDF',
      description: 'Crear reporte de recepción con firma del cliente',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Enviar comprobante por WhatsApp',
      description: 'Compartir el PDF generado al número del cliente',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Sincronizar base de datos',
      description: 'Subir registros offline cuando haya conexión',
      priority: 'Baja',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  List<Task> getTasks() => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
