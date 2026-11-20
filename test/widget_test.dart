import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:taskflow/app/taskflow_app.dart';
import 'package:taskflow/features/tasks/data/local_task_repository.dart';
import 'package:taskflow/features/tasks/data/task_repository.dart';
import 'package:taskflow/features/tasks/presentation/tasks_view_model.dart';

void main() {
  testWidgets('TaskFlow inicia correctamente', (WidgetTester tester) async {
    final TaskRepository repository = LocalTaskRepository();

    await tester.pumpWidget(
      ChangeNotifierProvider<TasksViewModel>(
        create: (_) => TasksViewModel(repository),
        child: const TaskFlowApp(),
      ),
    );

    expect(find.byType(TaskFlowApp), findsOneWidget);
  });
}
