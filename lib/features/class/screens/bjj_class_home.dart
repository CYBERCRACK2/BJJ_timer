import 'package:bjj_timer/core/sound_manager.dart';
import 'package:bjj_timer/features/class/widgets/class_mode_selector.dart';
import 'package:bjj_timer/features/class/widgets/simple_clock.dart';
import 'package:flutter/material.dart';

class BjjClassHome extends StatefulWidget {
  const BjjClassHome({super.key});

  @override
  State<BjjClassHome> createState() => _BjjClassHomeState();
}

class _BjjClassHomeState extends State<BjjClassHome> {
  ClassViewMode _currentMode = ClassViewMode.clock;
  Duration _selectedTime = Duration.zero;
  bool isPaused = false;

  @override
  void dispose() {
    AudioService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final isPortrait = size.height > size.width;
    // final dynamicWidth = isPortrait ? 1.0 : 0.78;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: isLandscape ? null : AppBar(title: Text("MODO Clase")),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AudioService.stop();
                          setState(() {
                            _currentMode = ClassViewMode.grid;
                          });
                        },
                        child: Icon(Icons.timer_outlined),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          AudioService.stop();
                          setState(() {
                            _currentMode = ClassViewMode.clock;
                          });
                        },
                        child: Icon(Icons.access_time_outlined),
                      ),
                    ],
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SimpleClock(),
                      ),
                    ),
                  ),
                ],
              ),
              ClassModeSelector(
                currentMode: _currentMode, // Le pasas el estado actual
                selectedDuration: _selectedTime, // Le pasas la duración elegida
                onTimeSelected: (duration) {
                  // guardar el tiempo en el padre
                  _selectedTime = duration;
                  // Cambiar el modo
                  setState(() {
                    _currentMode = ClassViewMode.timer;
                  });
                },
                isPaused: isPaused,
                onFinished: () {
                  setState(() {
                    _currentMode = ClassViewMode.grid;
                  });
                },
              ),
              Padding(padding: const EdgeInsets.all(12), child: Text("logo")),
            ],
          ),
        ),
      ),
    );
  }
}
