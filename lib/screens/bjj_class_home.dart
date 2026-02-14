import 'package:bjj_timer/components/simple_clock.dart';
import 'package:flutter/material.dart';

class BjjClassHome extends StatelessWidget {
  const BjjClassHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(children: [Text("tiempo seleccionado")]),
          SimpleClock(),
          Row(
            //buttons
            children: [
              Row(
                children: [
                  ElevatedButton(onPressed: () => {}, child: Text("bton 1")),
                  ElevatedButton(onPressed: () => {}, child: Text("bton 1")),
                  ElevatedButton(onPressed: () => {}, child: Text("bton 1")),
                ],
              ),
              Text("logo"),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeButton extends StatelessWidget {
  final String name;

  const TimeButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(name));
  }
}
