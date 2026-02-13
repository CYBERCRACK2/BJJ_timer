import 'package:flutter/material.dart';

class ExitDialogs {
  /// Muestra un diálogo de confirmación y devuelve true si el usuario quiere salir.
  static Future<bool> confirmExit({
    required BuildContext context,
    required String question,
    required String adviceText,
    required String textConfirm,
    required String textCancel,
  }) async {
    final double screenWidth = MediaQuery.of(context).size.width;

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              question,
              style: TextStyle(
                fontSize: (screenWidth * 0.05).clamp(16.0, 24.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              adviceText,
              style: TextStyle(
                fontSize: (screenWidth * 0.04).clamp(14.0, 18.0),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: FittedBox(
                  child: Text(
                    textConfirm,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: FittedBox(
                  child: Text(
                    textCancel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
