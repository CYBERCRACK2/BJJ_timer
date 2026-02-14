import 'package:bjj_timer/screens/absolute_home.dart';
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
      title: "BJJ Timer",
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
        body: AbsoluteHome(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
