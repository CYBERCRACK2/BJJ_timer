import 'package:flutter/material.dart';
import 'package:bjj_timer/components/time_selector.dart';
import 'package:bjj_timer/components/fight_button.dart';

class BjjTimerHome extends StatefulWidget {
  const BjjTimerHome({super.key});

  @override
  State<BjjTimerHome> createState() => _BjjTimerHomeState();
}

class _BjjTimerHomeState extends State<BjjTimerHome> {
  String sparringTime = "05:00";
  String restTime = "01:00";
  String rondas = "5";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.extent(
            maxCrossAxisExtent: 900, // El ancho máximo de cada tarjeta
            mainAxisSpacing: 00,
            crossAxisSpacing: 00,
            padding: const EdgeInsets.all(0),
            // Importante para que las tarjetas no se estiren verticalmente infinito:
            childAspectRatio: 2.8,
            children: [
              TimeSelectorBjj(
                name: "Tiempo de sparring",
                time: sparringTime,
                onChanged: (String value) {
                  debugPrint("El timepo de sparring es $value");
                  setState(() {
                    sparringTime = value;
                  });
                },
              ),
              TimeSelectorBjj(
                name: "Tiempo de descanso",
                time: restTime,
                onChanged: (String value) {
                  debugPrint("El timepo de descanso es $value");
                  setState(() {
                    restTime = value;
                  });
                },
              ),
              TimeSelectorBjj(
                name: "numero de rondas",
                isclock: false,
                time: rondas,
                onChanged: (String value) {
                  debugPrint("Las rondas son $value");
                  setState(() {
                    rondas = value;
                  });
                },
              ),
            ],
          ),
        ),
        FightButton(
          sparringTime: sparringTime,
          restTime: restTime,
          rondas: rondas,
        ),
      ],
    );
  }
}
