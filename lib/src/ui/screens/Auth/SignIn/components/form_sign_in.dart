import 'package:fingen/src/ui/components/Button/index.dart';
import 'package:fingen/src/ui/components/Form/Input/index.dart';
import 'package:fingen/src/ui/screens/Home/index.dart';
import 'package:flutter/material.dart';

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key});

  @override
  State<FormSignIn> createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const FormInputComponent(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const FormInputComponent(
            label: 'Senha',
            isPassword: true,
          ),
          ButtonComponent(
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen())
              );
            },
            label: 'Entrar',
          ),
        ],
      ),
    );
  }
}