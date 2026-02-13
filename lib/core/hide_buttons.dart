import 'dart:async';
import 'package:flutter/material.dart';

class ControlsOverlay extends StatefulWidget {
  final Widget child; // Tus botones (FightControls)
  final Duration hideDuration;

  const ControlsOverlay({
    super.key,
    required this.child,
    this.hideDuration = const Duration(seconds: 3),
  });

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  bool _isVisible = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(widget.hideDuration, () {
      if (mounted) setState(() => _isVisible = false);
    });
  }

  void toggleControls() {
    setState(() => _isVisible = !_isVisible);
    if (_isVisible) _startTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: toggleControls, // Al tocar cualquier parte, se muestran
      child: Stack(
        children: [
          // Un área invisible que detecta toques en toda la pantalla
          const Positioned.fill(child: SizedBox()),

          // Los controles con animación
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isVisible ? 1.0 : 0.0,
              child: IgnorePointer(ignoring: !_isVisible, child: widget.child),
            ),
          ),
        ],
      ),
    );
  }
}
