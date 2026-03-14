import 'package:bjj_timer/features/class/modules/selection_grid_view.dart';
import 'package:bjj_timer/features/class/widgets/simple_timer.dart';
import 'package:flutter/material.dart';
import 'simple_clock.dart';

enum ClassViewMode { clock, grid, timer }

class ClassModeSelector extends StatelessWidget {
  final ClassViewMode currentMode;
  final Duration selectedDuration;
  final Function(Duration) onTimeSelected;
  final VoidCallback onFinished;
  final bool isPaused;

  const ClassModeSelector({
    super.key,
    required this.currentMode,
    required this.selectedDuration,
    required this.onTimeSelected,
    required this.onFinished,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    // Aquí es donde vive tu switch, ahora de forma independiente
    switch (currentMode) {
      case ClassViewMode.clock:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FittedBox(child: SimpleClock()),
        );

      case ClassViewMode.grid:
        // Aquí puedes colocar tu GridView más adelante
        return SelectionGridView(
          onTimeSelected: (duracionSeleccionada) => {
            onTimeSelected(duracionSeleccionada),
          },
        );

      case ClassViewMode.timer:
        // Aquí irá tu widget de cuenta regresiva
        return BjjTimerWidget(
          isPaused: isPaused,
          duration: selectedDuration,
          onFinished: () => onFinished.call(),
        );
    }
  }
}
