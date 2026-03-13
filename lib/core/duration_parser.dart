Duration parsearDuration(String input) {
  // Eliminamos cualquier signo menos que el usuario intente meter
  final cleanInput = input.replaceAll('-', '').trim();

  if (cleanInput.isEmpty) return Duration.zero;

  if (cleanInput.contains(':')) {
    final parts = cleanInput.split(':');
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
    // Usamos .abs() por seguridad extra
    return Duration(minutes: minutes.abs(), seconds: seconds.abs());
  }

  final minutesOnly = int.tryParse(cleanInput) ?? 0;
  return Duration(minutes: minutesOnly.abs());
}
