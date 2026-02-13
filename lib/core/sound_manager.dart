import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  // Constructor privado para evitar que alguien accidentalmente instancie la clase
  AudioService._();

  // El reproductor es único y estático
  static final AudioPlayer _player = AudioPlayer();
  // El estado del player
  static PlayerState get currentState => _player.state;
  // Función principal para reproducir
  static Future<void> playEffect(String assetPath) async {
    try {
      // Importante para Linux/Android: detiene el anterior antes de iniciar el nuevo
      // para evitar conflictos de cookies de audio
      await _player.stop();
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint("AudioService Error: $e");
    }
  }

  static Future<void> pause() async {
    await _player.pause();
  }

  static Future<void> seek() async {
    await _player.seek(Duration.zero);
  }

  static Future<void> pauseToggle() async {
    try {
      if (currentState == PlayerState.playing) {
        await _player.pause();
      } else if (currentState == PlayerState.paused) {
        await _player.resume();
      } else {
        Error.safeToString("error del reproductor");
      }
    } catch (e) {
      debugPrint("Error en: $e");
    }
  }

  // Sonidos predefinidos
  static void playStartBell() => playEffect("sounds/ringstimer.wav");
  static void playEndBell() => playEffect("sounds/BoxingBell.wav");

  // Limpieza total
  static void dispose() {
    try {
      _player.dispose();
      debugPrint("AudioService: Recursos de audio liberados.");
    } catch (e) {
      debugPrint("Error al cerrar AudioPlayer: $e");
    }
  }
}
