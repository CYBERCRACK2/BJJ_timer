import 'package:flutter/material.dart';

class SimpleClock extends StatelessWidget {
  const SimpleClock({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      ),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();

        // Formateo directo a String
        final String time =
            "${now.hour.toString().padLeft(2, '0')}:"
            "${now.minute.toString().padLeft(2, '0')}:"
            "${now.second.toString().padLeft(2, '0')}";

        return Text(
          time,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
