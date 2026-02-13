import 'package:bjj_timer/screens/bjj_timer_home.dart';
import 'package:flutter/material.dart';
import 'core/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: BjjTheme.lightTheme,
      darkTheme: BjjTheme.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Configurar Tiempo", textAlign: TextAlign.center),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => {},
                icon: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        body: BjjTimerHome(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


// Work Time: El tiempo de la lucha.

// Rest Time: El tiempo de descanso entre rondas.

// Rounds: El número de veces que se repite el ciclo.

// Audio cues: Avisos sonoros (clave en BJJ porque no siempre puedes mirar la pantalla).