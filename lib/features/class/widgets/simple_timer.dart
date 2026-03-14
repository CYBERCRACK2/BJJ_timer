import 'dart:async';
import 'package:bjj_timer/core/sound_manager.dart';
import 'package:flutter/material.dart';

class BjjTimerWidget extends StatefulWidget {
  final Duration duration;
  final VoidCallback onFinished;
  final bool isPaused;

  const BjjTimerWidget({
    super.key,
    required this.duration,
    required this.onFinished,
    required this.isPaused,
  });

  @override
  State<BjjTimerWidget> createState() => _BjjTimerWidgetState();
}

// Usamos SingleTickerProviderStateMixin para manejar la animación de forma fluida
class _BjjTimerWidgetState extends State<BjjTimerWidget>
    with SingleTickerProviderStateMixin {
  late Duration _timeLeft;
  Timer? _timer;

  // Controladores para la animación de parpadeo suave
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  bool _isPrepMode = true;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.duration;

    // 1. Configuramos la animación de parpadeo (fade)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Velocidad del pulso
    );

    _opacityAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve:
            Curves.easeInOut, // Hace que el fundido sea progresivo y no brusco
      ),
    );

    // 2. Iniciamos el parpadeo infinito (ida y vuelta)
    _animationController.repeat(reverse: true);

    // 3. Iniciamos el conteo de los 4 segundos de espera
    _startCountdown();
  }

  void _startCountdown() {
    AudioService.playStartBell();
    // Timer de 4 segundos para la fase de preparación
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isPrepMode = false;
          _animationController.stop(); // Detenemos el parpadeo
          _animationController.value = 1.0; // Lo dejamos totalmente visible
          _startMainTimer(); // Empezamos el descuento real
        });
      }
    });
  }

  void _startMainTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.isPaused) return;
      if (mounted) {
        setState(() {
          if (_timeLeft.inSeconds > 0) {
            _timeLeft -= const Duration(seconds: 1);
          } else {
            AudioService.playEndBell();
            _timer?.cancel();
            widget.onFinished();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose(); // Limpieza de recursos
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: FadeTransition(
          // Aplicamos la opacidad animada solo si estamos en modo prep
          opacity: _isPrepMode
              ? _opacityAnimation
              : const AlwaysStoppedAnimation(1.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              _formatDuration(_timeLeft),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                // // Color resaltante para el aviso antes de empezar
                // color: _isPrepMode ? Colors.orange : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
