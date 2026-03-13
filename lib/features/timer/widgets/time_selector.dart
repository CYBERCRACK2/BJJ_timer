// Pasar nuevos argumentos para hacer mas logica del otro lado
//
import 'package:bjj_timer/core/format_time.dart';
import 'package:flutter/material.dart';

class SelectorBjj<T> extends StatelessWidget {
  final String label;
  final T value;
  final String textDisplay;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Function(String) onManualInput;
  final bool isclock;

  const SelectorBjj({
    super.key,
    required this.label,
    required this.value,
    required this.textDisplay,
    required this.onIncrement,
    required this.onDecrement,
    required this.onManualInput,
    this.isclock = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double baseUnit = constraints.maxWidth;
        // Definimos un tamaño de icono proporcional al ancho
        double iconSize = (baseUnit * 0.12).clamp(30.0, 60.0);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    label.toUpperCase(),
                    style: TextStyle(
                      fontSize: baseUnit * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          iconSize: iconSize,
                          onPressed: onDecrement,
                        ),
                        // 1. Usamos Expanded para que el área del número use todo el centro
                        Expanded(
                          child: Center(
                            // 2. FittedBox hace que el contenido crezca hasta los límites
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: IntrinsicWidth(
                                child: TextField(
                                  // Nota: Crear el controller aquí puede mover el cursor al inicio al escribir.
                                  // Si te pasa, considera pasar el controller desde el padre.
                                  controller: TextEditingController(
                                    text: textDisplay,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    if (isclock)
                                      TimeFormatter()
                                    else
                                      RoundFormatter(),
                                  ],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        100, // Tamaño base grande para calidad de renderizado
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                  ),
                                  onSubmitted: onManualInput,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          iconSize: iconSize,
                          onPressed: onIncrement,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
