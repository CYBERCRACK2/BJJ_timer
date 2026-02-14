import 'package:flutter/services.dart';

// 1. EL FORMATEADOR (Ponlo al principio del archivo, fuera de las clases)
class TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Extraer solo los números
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 2. Si se borra todo, regresamos vacío
    if (digits.isEmpty) return newValue;

    // 3. Limitar a 4 caracteres máximos (MMSS)
    if (digits.length > 4) digits = digits.substring(0, 4);

    // 4. LÓGICA INTELIGENTE DE RE-CÁLCULO
    // Si tenemos al menos 3 dígitos, verificamos si los segundos (decenas) son > 5
    // if (digits.length >= 3) {
    //   int minutes = int.parse(digits.substring(0, digits.length - 2));
    //   int seconds = int.parse(digits.substring(digits.length - 2));

    //   // Si los segundos son 60 o más (ej: usuario puso un 6 o 7 en la posición 3)
    //   if (seconds >= 60) {
    //     int extraMinutes = seconds ~/ 60;
    //     int remainingSeconds = seconds % 60;

    //     minutes += extraMinutes;
    //     seconds = remainingSeconds;

    //     // Re-armar el string de dígitos corregido
    //     String mStr = minutes.toString().padLeft(2, '0');
    //     String sStr = seconds.toString().padLeft(2, '0');
    //     digits = mStr + sStr;
    //   }
    // }

    // 5. Aplicar el formato visual MM:SS
    String formatted = '';
    for (int i = 0; i < digits.length; i++) {
      formatted += digits[i];
      // Insertar ":" después del segundo dígito si hay más
      if (i == 1 && digits.length > 2) {
        formatted += ':';
      }
    }

    // 6. Validación final de longitud para el cursor
    // (Evita que el cursor se pierda si MM crece a 3 dígitos, aunque lo limitamos a 99)
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class RoundFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Si el campo está vacío, permitimos el borrado
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 2. Intentamos parsear el número
    final int? value = int.tryParse(newValue.text);

    // 3. Si no es un número o es menor a 0 o mayor a 99, rechazamos el cambio
    if (value == null || value < 0 || value > 99) {
      return oldValue;
    }

    // 4. Evitamos ceros a la izquierda innecesarios (ej: "05" -> "5")
    // Pero permitimos el "0" solo si es el único carácter
    if (newValue.text.length > 1 && newValue.text.startsWith('0')) {
      return TextEditingValue(
        text: value.toString(),
        selection: TextSelection.collapsed(offset: value.toString().length),
      );
    }

    return newValue;
  }
}
