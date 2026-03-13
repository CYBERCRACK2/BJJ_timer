extension DurationFormatter on Duration {
  // Quitamos el argumento entre paréntesis
  String toMinutesSeconds() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    // Usamos 'inMinutes' directamente (se refiere al valor de la duración)
    String twoDigitMinutes = twoDigits(inMinutes);
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
