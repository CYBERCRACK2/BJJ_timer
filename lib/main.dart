import 'package:bjj_timer/screens/absolute_home.dart';
import 'package:bjj_timer/screens/info.dart';
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
          title: Text("BJJ home", textAlign: TextAlign.center),
          actions: [
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Info()),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                );
              },
            ),
          ],
        ),
        body: AbsoluteHome(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
