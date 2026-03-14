import 'package:bjj_timer/features/home/screens/absolute_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Permitir todas las orientaciones de forma controlada
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // 2. Modo inmersivo para que las barras de Android no tapen el reloj
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BJJ Timer",
      theme: AppTheme(isDarkMode: false).getTheme(),
      darkTheme: AppTheme(isDarkMode: true).getTheme(),
      home: const AbsoluteHome(),
    );
  }
}
