import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const TimeButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // CORRECCIÓN: Ejecuta la función directamente
      onPressed: onPressed,
      style:
          ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            overlayColor: Theme.of(context).colorScheme.inversePrimary,
          ).copyWith(
            // AGREGAMOS EL BORDE DINÁMICO
            side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
              if (states.contains(WidgetState.focused)) {
                return const BorderSide(
                  color: Color.fromARGB(255, 255, 0, 0),
                  width: 10,
                );
              }
              return BorderSide.none; // Sin borde en estado normal
            }),
          ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          name,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: const Color(0xFF000000),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
