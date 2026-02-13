class TimeParser {
  /// Recibe un string de números y devuelve formato MM:SS
  /// Ejemplo: "5" -> "05:00", "130" -> "01:30"
  static String format(String input) {
    // 1. Limpiar el string para dejar solo números
    String digits = input.replaceAll(RegExp(r'[^0-9]'), '');

    // 2. Si está vacío, devolver el formato base
    if (digits.isEmpty) return "00:00";

    // 3. Lógica de autocompletado según la cantidad de dígitos
    if (digits.length <= 2) {
      // "5" -> "05:00" | "12" -> "12:00"
      return "${digits.padLeft(2, '0')}:00";
    } else if (digits.length == 3) {
      // "130" -> "01:30"
      return "0${digits[0]}:${digits.substring(1)}";
    } else {
      // "1245" -> "12:45" (Tomamos máximo 4 dígitos)
      String minutes = digits.substring(0, 2);
      String seconds = digits.substring(2, 4);
      return "$minutes:$seconds";
    }
  }

  static String addOneMinute(String currentTime) {
    // 1. Dividir el string por los dos puntos
    List<String> parts = currentTime.split(':');

    // 2. Extraer minutos (si no hay, por defecto 0)
    int minutes = int.tryParse(parts[0]) ?? 0;

    // 3. Extraer segundos (si no hay, por defecto 0)
    // Usamos el valor original de segundos para no perderlos al sumar minutos
    String seconds = parts.length > 1 ? parts[1] : "00";

    // 4. Sumar el minuto (puedes poner un límite, ej: 99)
    minutes++;
    if (minutes > 99) minutes = 99;

    // 5. Retornar con formato 00:00 (padLeft asegura los dos dígitos)
    return "${minutes.toString().padLeft(2, '0')}:$seconds";
  }

  /// Resta 1 minuto al string de tiempo y devuelve el nuevo string (mínimo 00)
  static String subtractOneMinute(String currentTime) {
    // 1. Dividir el string por los dos puntos
    List<String> parts = currentTime.split(':');

    // 2. Extraer minutos (si no hay, por defecto 0)
    int minutes = int.tryParse(parts[0]) ?? 0;

    // 3. Extraer segundos (si no hay, por defecto 0)
    String seconds = parts.length > 1 ? parts[1] : "00";

    // 4. Restar el minuto solo si es mayor a 0
    if (minutes > 0) {
      minutes--;
    }

    // 5. Retornar con formato 00:SS
    return "${minutes.toString().padLeft(2, '0')}:$seconds";
  }

  /// Suma 1 a un valor numérico en formato String
  static String addOne(String currentVal) {
    int value = int.tryParse(currentVal) ?? 0;
    value++;
    return value.toString();
  }

  /// Resta 1 a un valor numérico en formato String (mínimo 0)
  static String subtractOne(String currentVal) {
    int value = int.tryParse(currentVal) ?? 0;
    if (value > 0) {
      value--;
    }
    return value.toString();
  }
}
