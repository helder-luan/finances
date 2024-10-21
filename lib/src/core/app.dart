import 'package:fingen/firebase_options.dart';
import 'package:fingen/src/theme/themes.dart';
import 'package:fingen/src/ui/screens/Auth/SignIn/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinGen',
      theme: FinancesTheme.lightTheme,
      home: const SignIn(),
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