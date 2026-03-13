Duration parsearDuration(String input) {
  // 1. Limpieza inicial
  String cleanInput = input.replaceAll(RegExp(r'[^0-9:]'), '').trim();
  if (cleanInput.isEmpty) return Duration.zero;

  int minutes = 0;
  int seconds = 0;

  // 2. Caso con ":" (ej: "5:3" -> "05:03")
  if (cleanInput.contains(':')) {
    final parts = cleanInput.split(':');
    minutes = int.tryParse(parts[0]) ?? 0;
    seconds = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
  }
  // 3. Caso sin ":" (ej: "123" -> "01:23", "5" -> "00:05")
  else {
    // Rellenamos con ceros a la izquierda hasta tener al menos 3 o 4 dígitos para MMSS
    // Si escribe "5", se convierte en "05", si escribe "123", se queda "123"
    if (cleanInput.length <= 2) {
      // Si quieres que "5" sean 5 minutos, usa: minutes = int.parse(cleanInput);
      // Pero para un Timer suele ser: 5 segundos.
      seconds = int.tryParse(cleanInput) ?? 0;
    } else {
      // Tomamos los últimos dos como segundos y el resto como minutos
      String sPart = cleanInput.substring(cleanInput.length - 2);
      String mPart = cleanInput.substring(0, cleanInput.length - 2);
      minutes = int.tryParse(mPart) ?? 0;
      seconds = int.tryParse(sPart) ?? 0;
    }
  }

  // 4. Aplicamos la lógica de desbordamiento (62 seg -> 1 min 02 seg)
  if (seconds >= 60) {
    minutes += seconds ~/ 60;
    seconds = seconds % 60;
  }

  return Duration(minutes: minutes.abs(), seconds: seconds.abs());
}
