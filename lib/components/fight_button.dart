import 'package:flutter/material.dart';
import 'package:bjj_timer/screens/bjj_timer_fight_home.dart';

class FightButton extends StatelessWidget {
  final String sparringTime;
  final String restTime;
  final String rondas;

  const FightButton({
    super.key,
    required this.sparringTime,
    required this.restTime,
    required this.rondas,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BjjTimerFight(
                sparringTime: sparringTime,
                restTime: restTime,
                rondas: rondas,
              ),
            ),
          );
        },
        child: Text("INICIAR SPARRING", textAlign: TextAlign.center),
      ),
    );
  }
}
