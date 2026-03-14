import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("info"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "mi informacion",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('''lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfalañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          lañskjdfñlkasdfasdfa
          ''', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
