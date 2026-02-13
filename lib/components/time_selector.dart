import 'package:flutter/material.dart';
import 'package:bjj_timer/core/format_time.dart';
import 'package:bjj_timer/core/time_parser.dart';

class TimeSelectorBjj extends StatefulWidget {
  final String name;
  final bool isclock;
  final String time;
  final Function(String) onChanged;

  const TimeSelectorBjj({
    super.key,
    required this.name,
    this.isclock = true,
    required this.time,
    required this.onChanged,
  });

  @override
  State<TimeSelectorBjj> createState() => _TimeSelectorBjjState();
}

class _TimeSelectorBjjState extends State<TimeSelectorBjj> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculamos un tamaño base para la fuente y los iconos
        double baseUnit = constraints.maxWidth;
        double fontSize = (baseUnit * 0.15).clamp(20.0, 80.0);
        double iconSize = (baseUnit * 0.1).clamp(24.0, 48.0);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: (baseUnit * 0.05).clamp(14.0, 24.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: iconSize,
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (widget.isclock) {
                          setState(() {
                            String nuevoTiempo = TimeParser.subtractOneMinute(
                              widget.time,
                            );
                            widget.onChanged(nuevoTiempo);
                          });
                        } else {
                          setState(() {
                            String nuevoTiempo = TimeParser.subtractOne(
                              widget.time,
                            );
                            widget.onChanged(nuevoTiempo);
                          });
                        }
                      },
                    ),
                    // Contenedor con ancho dinámico para el TextField
                    SizedBox(
                      width:
                          baseUnit *
                          0.6, // Ocupa el 40% del ancho de la tarjeta
                      height: baseUnit * 0.2,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: TextEditingController(
                          text: widget.time,
                        ), // USA EL CONTROLADOR DEL STATE
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          if (widget.isclock)
                            TimeFormatter()
                          else
                            RoundFormatter(),
                        ],
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: fontSize),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: widget.isclock ? "00:00" : "-",
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (widget.isclock) {
                              widget.onChanged(TimeParser.format(value));
                            } else {
                              widget.onChanged(value);
                            }
                          });
                        },
                        onEditingComplete: () {
                          _focusNode.unfocus();
                        },
                      ),
                    ),
                    IconButton(
                      iconSize: iconSize,
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        if (widget.isclock) {
                          setState(() {
                            String nuevoTiempo = TimeParser.addOneMinute(
                              widget.time,
                            );
                            widget.onChanged(nuevoTiempo);
                          });
                        } else {
                          setState(() {
                            String nuevoTiempo = TimeParser.addOne(widget.time);
                            widget.onChanged(nuevoTiempo);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
