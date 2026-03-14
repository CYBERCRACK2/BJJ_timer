import 'package:bjj_timer/features/class/screens/bjj_class_home.dart';
import 'package:bjj_timer/features/home/screens/info.dart';
import 'package:bjj_timer/features/timer/screens/bjj_timer_home.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AbsoluteHome extends StatelessWidget {
  const AbsoluteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
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
                  name: "CLASS",
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
          child: Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontSize: 0.07 * resolution),
          ),
        ),
      ),
    );
  }
}
