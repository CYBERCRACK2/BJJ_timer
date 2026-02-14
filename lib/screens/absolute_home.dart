import 'package:flutter/material.dart';

class AbsoluteHome extends StatelessWidget {
  const AbsoluteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () => {}, child: Text("class")),
          ElevatedButton(onPressed: () => {}, child: Text("Open mat")),
        ],
      ),
    );
  }
}
