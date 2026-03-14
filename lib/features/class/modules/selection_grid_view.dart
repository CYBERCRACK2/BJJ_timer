import 'package:bjj_timer/core/format_duration.dart';
import 'package:bjj_timer/features/class/widgets/time_standard_class_button.dart';
import 'package:flutter/material.dart';

class SelectionGridView extends StatelessWidget {
  // El callback que enviará la duración seleccionada al padre
  final Function(Duration) onTimeSelected;

  const SelectionGridView({super.key, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    final List<Duration> times = [
      Duration(seconds: 30),
      Duration(minutes: 1),
      Duration(minutes: 2),
      Duration(minutes: 3),
      Duration(minutes: 4),
      Duration(minutes: 5),
      Duration(minutes: 10),
      Duration(minutes: 20),
    ];

    return Expanded(
      child: Padding(
        padding: !isPortrait
            ? EdgeInsets.symmetric(horizontal: 130).copyWith(top: 30)
            : EdgeInsets.only(),
        child: GridView.builder(
          // 1. IMPORTANTE: false para que el Expanded maneje el scroll
          shrinkWrap: false,
          physics: const BouncingScrollPhysics(),

          // 2. Padding para que no pegue a los bordes
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          // 3. CAMBIO CLAVE: Usamos MaxCrossAxisExtent para que sea responsivo
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // Si el espacio es > 400px, pondrá 2 columnas.
            // Si es > 800px (pantalla grande u horizontal), pondrá 4 o más.
            maxCrossAxisExtent: !isPortrait ? 400 : 250,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio:
                1.1, // Ajusta esto según prefieras la forma del botón
          ),

          itemCount: times.length,
          itemBuilder: (context, index) {
            final Duration minutes = times[index];
            return TimeButton(
              name: minutes.toMinutesSeconds(),
              onPressed: () => onTimeSelected(minutes),
            );
          },
        ),
      ),
    );
  }
}
