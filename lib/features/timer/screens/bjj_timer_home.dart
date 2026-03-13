import 'package:bjj_timer/core/format_duration.dart';
import 'package:flutter/material.dart';
import 'package:bjj_timer/features/timer/widgets/time_selector.dart';
import 'package:bjj_timer/features/timer/widgets/fight_button.dart';
import 'package:bjj_timer/core/duration_parser.dart';

class BjjTimerHome extends StatefulWidget {
  const BjjTimerHome({super.key});

  @override
  State<BjjTimerHome> createState() => _BjjTimerHomeState();
}

class _BjjTimerHomeState extends State<BjjTimerHome> {
  Duration sparringTime = Duration(minutes: 5);
  Duration restTime = Duration(minutes: 1);
  int rondas = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MODO open mat", textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.extent(
                maxCrossAxisExtent: 900, // El ancho máximo de cada tarjeta
                mainAxisSpacing: 00,
                crossAxisSpacing: 00,
                padding: const EdgeInsets.all(0),
                // Importante para que las tarjetas no se estiren verticalmente infinito:
                childAspectRatio: 2.8,
                children: [
                  SelectorBjj<Duration>(
                    label: "TIEMPO DE SPARRING",
                    value: sparringTime,
                    textDisplay: sparringTime
                        .toMinutesSeconds(), // Usando la extensión que vimos antes
                    onIncrement: () => setState(
                      () => sparringTime += const Duration(seconds: 30),
                    ),
                    onDecrement: () {
                      setState(() {
                        // Solo restamos si es mayor a 1 minuto (o 0)
                        if (sparringTime.inSeconds > 29) {
                          sparringTime -= const Duration(seconds: 30);
                        }
                      });
                    },
                    onManualInput: (val) => setState(() {
                      sparringTime = parsearDuration(val);
                    }),
                  ),
                  SelectorBjj<Duration>(
                    label: "TIEMPO DE DESCANSO",
                    value: restTime,
                    textDisplay: restTime
                        .toMinutesSeconds(), // Usando la extensión que vimos antes
                    onIncrement: () =>
                        setState(() => restTime += const Duration(seconds: 30)),
                    onDecrement: () {
                      setState(() {
                        // Solo restamos si es mayor a 1 minuto (o 0)
                        if (restTime.inSeconds > 29) {
                          restTime -= const Duration(seconds: 30);
                        }
                      });
                    },
                    onManualInput: (val) => setState(() {
                      restTime = parsearDuration(val);
                    }),
                  ),
                  SelectorBjj<int>(
                    label: "RONDAS",
                    value: rondas,
                    textDisplay: rondas.toString(),
                    onIncrement: () => setState(() => rondas++),
                    onDecrement: () {
                      setState(() {
                        // Solo restamos si es mayor a 1 minuto (o 0)
                        if (rondas > 1) {
                          rondas--;
                        }
                      });
                    },
                    onManualInput: (val) =>
                        setState(() => rondas = int.tryParse(val) ?? 1),
                    isclock: false,
                  ),
                ],
              ),
            ),
          ),
          FightButton(
            sparringTime: sparringTime,
            restTime: restTime,
            rondas: rondas,
          ),
        ],
      ),
    );
  }
}
