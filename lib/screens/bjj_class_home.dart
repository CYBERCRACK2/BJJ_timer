import 'package:flutter/material.dart';

class BjjClassHome extends StatelessWidget {
  const BjjClassHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text("tiempo seleccionado"), Text("hora")]),
        Text("Hora"),
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
    );
  }
}
