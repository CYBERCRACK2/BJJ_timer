import 'package:flutter/services.dart';

// 1. EL FORMATEADOR (Ponlo al principio del archivo, fuera de las clases)
class TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Extraer SOLO números (esto elimina signos '-' automáticamente)
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // 2. Limitar a 4 caracteres (MMSS)
    if (digits.length > 4) {
      digits = digits.substring(0, 4);
    }

    // 3. Lógica de recalcular excedentes (ej: 62 segundos -> 1 min 02 seg)
    if (digits.length >= 3) {
      // Separamos los últimos dos dígitos como segundos y el resto como minutos
      int totalSeconds = int.parse(digits.substring(digits.length - 2));
      int totalMinutes = int.parse(digits.substring(0, digits.length - 2));

      if (totalSeconds >= 60) {
        totalMinutes += totalSeconds ~/ 60;
        totalSeconds = totalSeconds % 60;

        // Re-ensamblamos el string asegurando el formato
        String mStr = totalMinutes.toString();
        String sStr = totalSeconds.toString().padLeft(2, '0');
        digits = mStr + sStr;
      }
    }

    // 4. Aplicar el formato visual MM:SS
    String formatted = '';
    // Si solo hay 1 o 2 dígitos, son minutos (ej: "5" o "12")
    if (digits.length <= 2) {
      formatted = digits;
    }
    // Si hay más, ponemos los ":" antes de los últimos dos dígitos
    else {
      String minutesPart = digits.substring(0, digits.length - 2);
      String secondsPart = digits.substring(digits.length - 2);
      formatted = '$minutesPart:$secondsPart';
    }

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
