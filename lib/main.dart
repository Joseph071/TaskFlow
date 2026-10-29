import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP MOVIL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 183, 0, 255),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const studentName = 'PAREDES CARRILLO JOSEPH PAREDES';
    const pendingTasks = 67;
    const courseName = 'Desarrollo de aplicaciones móviles';
    const motivationalMessage =
        'No te rindas, entrenador. Cada batalla te enseña, cada derrota te prepara y cada paso te acerca a tu sueño. Confía en tu equipo y sigue adelante: ¡el camino para ser un Maestro Pokémon lo construyes tú!No te rindas, entrenador. Cada batalla te enseña, cada derrota te prepara y cada paso te acerca a tu sueño. Confía en tu equipo y sigue adelante: ¡el camino para ser un Maestro Pokémon lo construyes tú!';

    return Scaffold(
      appBar: AppBar(title: const Text('APP MOVIL'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.accessibility, size: 56),
            const SizedBox(height: 24),
            Text( 
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            Text(
              motivationalMessage,
              style: const TextStyle(
                fontSize: 16, 
              ),
            ),

            const SizedBox(height: 12),
            Text('Bienvenido/a a $courseName.'),

            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.add_to_home_screen_outlined),
                    const SizedBox(width: 12),
                    Text('Tareas pendientes: $pendingTasks'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
