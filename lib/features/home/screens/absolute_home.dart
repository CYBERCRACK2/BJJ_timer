import 'package:bjj_timer/features/class/bjj_class_home.dart';
import 'package:bjj_timer/features/timer/screens/bjj_timer_home.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AbsoluteHome extends StatelessWidget {
  const AbsoluteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ModeSelect(
              name: "OPEN MAT",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BjjTimerHome()),
                );
              },
            ),
            ModeSelect(
              name: "Class",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BjjClassHome()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Boton para seleccionar un modo
class ModeSelect extends StatelessWidget {
  final Function() onPressed;
  final String name;

  const ModeSelect({super.key, required this.onPressed, required this.name});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = (MediaQuery.of(context).size.height);
    final num resolution = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));

    return FittedBox(
      child: ElevatedButton(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name, style: TextStyle(fontSize: 0.07 * resolution)),
        ),
      ),
    );
  }
}
