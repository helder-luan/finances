import 'package:finances/src/data/database/database.dart';
import 'package:finances/src/ui/screens/Home/index.dart';
import 'package:flutter/material.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    DB.instance.initDB().then((_) async {
      runApp(const MyApp());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
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