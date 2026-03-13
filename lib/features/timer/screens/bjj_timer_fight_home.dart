// hacer este archivo completo nuevamente

import 'dart:math' as math;
import 'package:bjj_timer/features/timer/widgets/bjj_timer_core.dart';
import 'package:flutter/material.dart';
import 'package:bjj_timer/shared/exit_dialog.dart';
import 'package:bjj_timer/core/sound_manager.dart';

class BjjTimerFight extends StatefulWidget {
  final Duration sparringTime;
  final Duration restTime;
  final int rondas;

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
  bool isPaused = false;
  Color currentColor = Colors.blue;
  int currentRounds = 0;

  void _pauseTimer() {
    AudioService.pauseToggle();
    _timerKey.currentState?.togglePause();
  }

  void _resetTimer() async {
    final bool reset = await ExitDialogs.confirmExit(
      context: context,
      question: '¿Reiniciar la ronda?',
      adviceText: 'La ronda comenzará desde el inicio.',
      textConfirm: "Continuar",
      textCancel: "Reiniciar",
    );
    if (reset) {
      _timerKey.currentState?.pause();
      _timerKey.currentState?.resetRound();
    }
  }

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
      child: GestureDetector(
        onDoubleTap: () => _pauseTimer(),
        onLongPress: () => _resetTimer(),
        child: Scaffold(
          backgroundColor: currentColor,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FittedBox(
                        child: BjjTimerCore(
                          fightTime: widget
                              .sparringTime, // El tiempo de lucha que pasaste
                          restTime: widget.restTime, // El tiempo de descanso
                          totalRounds: widget.rondas,
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
                          onRoundChange: (rounds) => currentRounds = rounds,
                          key: _timerKey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 16,
                child: Text(
                  "$currentRounds/${widget.rondas}",
                  style: TextStyle(
                    fontSize: diagonal * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



                        // _buildResponsiveButton(
                        //   icon: isPaused
                        //       ? Icons.play_arrow_rounded
                        //       : Icons.pause_rounded,
                        //   size: diagonal * 0.12, //cambiar
                        //   onPressed: () {
                        //     AudioService.pauseToggle();
                        //     _timerKey.currentState?.togglePause();
                        //   },
                        // ),
                        // _buildResponsiveButton(
                        //   icon: Icons.replay,
                        //   size: diagonal * 0.12,
                        //   onPressed: () async {
                        //     final bool reset = await ExitDialogs.confirmExit(
                        //       context: context,
                        //       question: '¿Reiniciar la ronda?',
                        //       adviceText: 'La ronda comenzará desde el inicio.',
                        //       textConfirm: "Continuar",
                        //       textCancel: "Reiniciar",
                        //     );
                        //     if (reset) {
                        //       _timerKey.currentState?.pause();
                        //       _timerKey.currentState?.resetRound();
                        //     }
                        //   },
                        // ),