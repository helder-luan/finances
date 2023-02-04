import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// telas
import 'package:finances/src/ui/screens/Home/index.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finances',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF1400FF,
          {
            50 : Color(0xFF1400FF),
            100 : Color(0xFF1400FF),
            200 : Color(0xFF1400FF),
            300 : Color(0xFF1400FF),
            400 : Color(0xFF1400FF),
            500 : Color(0xFF1400FF),
            600 : Color(0xFF1400FF),
            700 : Color(0xFF1400FF),
            800 : Color(0xFF1400FF),
            900 : Color(0xFF1400FF)
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}