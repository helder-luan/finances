import 'package:fingen/firebase_options.dart';
import 'package:fingen/src/ui/screens/Autenticacao/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const Autenticacao(),
    );
  }
}

class AppFirebase extends StatelessWidget {
  AppFirebase({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Verifica se tem erros
        if (snapshot.hasError) {
          return const Center(
            child: Text('Ocorreu erro ao inicializar o Firebase'),
          );
        }

        // Se tudo der certo abre a aplicação
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Mostrar carregando
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}