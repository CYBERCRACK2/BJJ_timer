import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:bjj_timer/core/sound_manager.dart';

enum TimerPhase { preparation, fighting, resting, finished }

class BjjTimerCore extends StatefulWidget {
  final String fightTime; // Viene como "05:00"
  final String restTime; // Viene como "01:00"
  final int totalRounds;
  final TextStyle? textStyle;
  final bool isRound;
  final Function(Color)? onColorChange;
  final Function(bool)? onPauseToggle;

  const BjjTimerCore({
    super.key,
    required this.fightTime,
    required this.restTime,
    required this.totalRounds,
    required this.textStyle,
    required this.isRound,
    this.onColorChange,
    this.onPauseToggle,
  });

  @override
  State<BjjTimerCore> createState() => BjjTimerCoreState();
}

class BjjTimerCoreState extends State<BjjTimerCore> {
  Timer? _timer;
  int _currentSeconds = 0;
  int _currentRound = 1;
  TimerPhase _phase = TimerPhase.preparation;
  bool isPaused = false;

  @override
  void initState() {
    WakelockPlus.enable();
    super.initState();
    // Mantiene la pantalla encendida
    _startPhase(TimerPhase.preparation);
  }

  @override
  void dispose() {
    try {
      // 1. Limpiamos procesos de Dart
      _timer?.cancel();

      // 2. Limpiamos hardware de forma asíncrona y protegida
      _safeCleanup();

      AudioService.pause();

      super.dispose();
    } catch (e) {
      debugPrint("El error fue: {$e}");
    }
  }

  Future<void> _safeCleanup() async {
    try {
      // Intentamos apagar. No chequeamos .enabled porque puede mentir.
      // Simplemente pedimos la liberación y atrapamos cualquier queja del SO.
      await WakelockPlus.disable();
      debugPrint("Hardware: Recurso liberado correctamente.");
    } catch (e) {
      // Esto atrapará el Code36 en Linux y cualquier error de estado en Android
      debugPrint(
        "Hardware: El sistema ya había liberado el recurso o no era necesario.",
      );
    }
  }

  // Convierte "MM:SS" a segundos totales
  int _parseToSeconds(String time) {
    List<String> parts = time.split(':');
    int minutes = int.tryParse(parts[0]) ?? 0;
    int seconds = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return (minutes * 60) + seconds;
  }

  void _startPhase(TimerPhase newPhase) {
    setState(() {
      _phase = newPhase;
      switch (newPhase) {
        case TimerPhase.preparation: // Fase de Preparacion
          //debugPrint("$isPaused");
          if (!isPaused) {
            debugPrint("audio emitido");
            AudioService.playStartBell();
          } else {
            AudioService.pause();
            AudioService.seek();
          }
          _currentSeconds = 3; // Tus 3 segundos de preparación
          break;
        case TimerPhase.fighting: // Fase de Pelea
          _currentSeconds = _parseToSeconds(widget.fightTime);
          break;
        case TimerPhase.resting: // Fase de Reseteo
          if (!isPaused) {
            debugPrint("audio emitido");
            AudioService.playEndBell();
          } else {
            AudioService.pause();
            AudioService.seek();
          } // Campana de descanso
          _currentSeconds = _parseToSeconds(widget.restTime);
          break;
        case TimerPhase.finished: // Fase de final
          _currentSeconds = 0;
          _timer?.cancel();

          //notificar el ultimo color
          widget.onColorChange?.call(_getPhaseColor());

          // para que el usuario vea que llegó a 0
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              if (!widget.isRound) {
                Navigator.of(context).pop();
              } else {
                return;
              }
            }
          });
          return;
      }
      // Darle color al fondo
      Future.microtask(() async {
        if (mounted) {
          widget.onColorChange?.call(_getPhaseColor());
        }
      });
    });
    _runTimer();
  }

  void _runTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused) return;

      if (_currentSeconds > 0) {
        setState(() => _currentSeconds--);
      } else {
        _handlePhaseTransition();
      }
    });
  }

  void _handlePhaseTransition() {
    switch (_phase) {
      case TimerPhase.preparation:
        _startPhase(TimerPhase.fighting);
        break;

      case TimerPhase.fighting:
        if (_currentRound < widget.totalRounds) {
          _startPhase(TimerPhase.resting);
        } else {
          _startPhase(TimerPhase.finished);
        }
        break;

      case TimerPhase.resting:
        _currentRound++;
        _startPhase(TimerPhase.preparation);
        break;

      case TimerPhase.finished:
        debugPrint("Entrenamiento terminado");
        break;
    }
  }

  // Dentro de _BjjTimerCoreState
  void pause() {
    setState(() {
      isPaused = true;
    });
    widget.onPauseToggle?.call(isPaused);
  }

  // Dentro de _BjjTimerCoreState
  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
    widget.onPauseToggle?.call(isPaused);
  }

  // Reinicia la fase actual (recarga el tiempo)
  void resetRound() {
    _startPhase(_phase);
  }

  String _getFormatTime() {
    int m = _currentSeconds ~/ 60;
    int s = _currentSeconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  Color _getPhaseColor() {
    switch (_phase) {
      case TimerPhase.preparation:
        return Colors.orange;
      case TimerPhase.fighting:
        return Colors.green;
      case TimerPhase.resting:
        return Colors.blue;
      case TimerPhase.finished:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isRound) ...[
          // Si isRound es verdadero, SOLO se muestra esto
          Text(
            "R $_currentRound/${widget.totalRounds}",
            style: widget.textStyle,
          ),
        ] else ...[
          // Si isRound es falso, se muestra toda la lógica del temporizador
          if (_phase != TimerPhase.fighting)
            Text(switch (_phase) {
              TimerPhase.preparation => "¡PREPÁRATE!",
              TimerPhase.resting => "DESCANSO",
              TimerPhase.finished => "¡FINALIZADO!",
              _ => "",
            }, style: widget.textStyle),

          const SizedBox(height: 20),

          Text(_getFormatTime(), style: widget.textStyle),
        ],
      ],
    );
  }
}
