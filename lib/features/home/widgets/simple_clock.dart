import 'package:flutter/material.dart';

class SimpleClock extends StatelessWidget {
  final TextStyle? textStyle;
  final Color? backgroundColor;

  const SimpleClock({super.key, this.textStyle, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      // Se actualiza cada segundo
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      ),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();

        // Formateo de 2 dígitos: 09:05:01
        final String hours = now.hour.toString().padLeft(2, '0');
        final String minutes = now.minute.toString().padLeft(2, '0');
        final String seconds = now.second.toString().padLeft(2, '0');

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "$hours:$minutes:$seconds",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
      },
    );
  }
}
