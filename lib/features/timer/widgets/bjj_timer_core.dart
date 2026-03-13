import 'package:bjj_timer/core/format_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:bjj_timer/core/sound_manager.dart';

enum TimerPhase { preparation, fighting, resting, finished }

class BjjTimerCore extends StatefulWidget {
  final Duration fightTime; // Viene como "05:00"
  final Duration restTime; // Viene como "01:00"
  final int totalRounds;
  final Function(Color)? onColorChange;
  final Function(bool)? onPauseToggle;
  final Function(int)? onRoundChange;

  const BjjTimerCore({
    super.key,
    required this.fightTime,
    required this.restTime,
    required this.totalRounds,
    this.onColorChange,
    this.onPauseToggle,
    this.onRoundChange,
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
    // Pantalla completa
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // Mantiene la pantalla encendida
    WakelockPlus.enable();
    super.initState();
    _startPhase(TimerPhase.preparation);
  }

  @override
  void dispose() {
    try {
      // Quitar la pantalla completa
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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

  void _startPhase(TimerPhase newPhase) {
    setState(() {
      _phase = newPhase;
      switch (newPhase) {
        case TimerPhase.preparation: // Fase de Preparacion
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
          _currentSeconds = widget.fightTime.inSeconds;
          widget.onRoundChange?.call(_currentRound);
          break;
        case TimerPhase.resting: // Fase de Reseteo
          if (!isPaused) {
            debugPrint("audio emitido");
            AudioService.playEndBell();
          } else {
            AudioService.pause();
            AudioService.seek();
          } // Campana de descanso
          _currentSeconds = widget.restTime.inSeconds;
          break;

        case TimerPhase.finished: // Fase de final
          _currentSeconds = 0;
          _timer?.cancel();

          //notificar el ultimo color
          widget.onColorChange?.call(_getPhaseColor());

          // para que el usuario vea que llegó a 0
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pop();
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
        setState(() {
          _currentSeconds--;

          // // --- LÓGICA DE ÚLTIMOS 10 SEGUNDOS ---
          // if (_phase == TimerPhase.fighting && _currentSeconds == 10) {
          //   // 1. Sonido de aviso (asegúrate de tenerlo en tu AudioService)
          //   AudioService.playTenSecondsWarning();

          //   // 2. Cambiar color de fondo (notificar al padre)
          //   widget.onColorChange?.call(Colors.redAccent);
          // }
        });
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
    return Duration(seconds: _currentSeconds).toMinutesSeconds();
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
      mainAxisSize: MainAxisSize.max,
      children: [
        if (_phase != TimerPhase.fighting)
          Text(switch (_phase) {
            TimerPhase.preparation => "¡PREPÁRATE!",
            TimerPhase.resting => "DESCANSO",
            TimerPhase.finished => "¡FINALIZADO!",
            _ => "",
          }),
        Text(_getFormatTime(), style: TextStyle(fontWeight: FontWeight.w900)),
      ],
    );
  }
}
