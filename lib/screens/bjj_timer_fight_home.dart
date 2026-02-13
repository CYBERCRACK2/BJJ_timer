import 'dart:math' as math;
import 'package:bjj_timer/components/bjj_timer_core.dart';
import 'package:flutter/material.dart';
import 'package:bjj_timer/core/exit_dialog.dart';
import 'package:bjj_timer/core/hide_buttons.dart';
import 'package:bjj_timer/core/sound_manager.dart';

class BjjTimerFight extends StatefulWidget {
  final String sparringTime;
  final String restTime;
  final String rondas;

  const BjjTimerFight({
    super.key,
    required this.sparringTime,
    required this.restTime,
    required this.rondas,
  });

  @override
  State<BjjTimerFight> createState() => _BjjTimerFightState();
}

class _BjjTimerFightState extends State<BjjTimerFight> {
  final GlobalKey<BjjTimerCoreState> _timerKey = GlobalKey<BjjTimerCoreState>();
  final GlobalKey<BjjTimerCoreState> _timerKey2 =
      GlobalKey<BjjTimerCoreState>();
  bool isPaused = false;
  Color currentColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double diagonal = math.sqrt(
      screenWidth * screenHeight + screenWidth * screenHeight,
    );

    return PopScope(
      canPop:
          false, // Bloquea la salida automática (flecha de arriba y botón atrás)
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // 2. Llamamos a tu función externa
        final bool shouldPop = await ExitDialogs.confirmExit(
          context: context,
          question: '¿Detener entrenamiento?',
          adviceText: 'Si sales ahora, se perderá el progreso actual.',
          textCancel: "Salir",
          textConfirm: "Cancelar",
        );

        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: currentColor,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: FittedBox(
                child: BjjTimerCore(
                  fightTime:
                      widget.sparringTime, // El tiempo de lucha que pasaste
                  restTime: widget.restTime, // El tiempo de descanso
                  totalRounds: int.tryParse(widget.rondas) ?? 1,
                  textStyle: Theme.of(context).textTheme.headlineLarge,
                  isRound: false,
                  onColorChange: (newColor) {
                    setState(() {
                      currentColor = newColor;
                    });
                  },
                  onPauseToggle: (paused) {
                    setState(() {
                      isPaused =
                          paused; // Aquí sincronizamos el estado del hijo con el padre
                    });
                  },
                  key: _timerKey,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BOTÓN PAUSA
                    // BOTÓN PLAY/PAUSE (Icono)
                    ControlsOverlay(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildResponsiveButton(
                            icon: isPaused
                                ? Icons.play_arrow_rounded
                                : Icons.pause_rounded,
                            size: diagonal * 0.12, //cambiar
                            onPressed: () {
                              AudioService.pauseToggle();
                              _timerKey.currentState?.togglePause();
                              _timerKey2.currentState?.togglePause();
                            },
                          ),
                          _buildResponsiveButton(
                            icon: Icons.replay,
                            size: diagonal * 0.12,
                            onPressed: () async {
                              final bool reset = await ExitDialogs.confirmExit(
                                context: context,
                                question: '¿Reiniciar la ronda?',
                                adviceText:
                                    'La ronda comenzará desde el inicio.',
                                textConfirm: "Continuar",
                                textCancel: "Reiniciar",
                              );
                              if (reset) {
                                _timerKey.currentState?.pause();
                                _timerKey.currentState?.resetRound();
                                _timerKey2.currentState?.pause();
                                _timerKey2.currentState?.resetRound();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildRoundsDisplay(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper para no repetir código de botones
Widget _buildResponsiveButton({
  required IconData icon,
  required double size,
  required VoidCallback onPressed,
  //required int flex,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(size * 0.03), // Padding proporcional
      ),
      child: FittedBox(child: Icon(icon, size: size)),
    ),
  );
}

extension on _BjjTimerFightState {
  Widget _buildRoundsDisplay() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double diagonal = math.sqrt(
      screenWidth * screenHeight + screenWidth * screenHeight,
    );

    return BjjTimerCore(
      key: _timerKey2,
      fightTime: widget.sparringTime,
      restTime: widget.restTime,
      totalRounds: int.tryParse(widget.rondas) ?? 1,
      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: diagonal * 0.06,
      ),
      isRound: true,
    );
  }
}
