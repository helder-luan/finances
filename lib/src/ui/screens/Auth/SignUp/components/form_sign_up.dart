import 'package:fingen/src/ui/components/Button/index.dart';
import 'package:fingen/src/ui/components/Form/Input/index.dart';
import 'package:fingen/src/ui/screens/Auth/SignIn/index.dart';
import 'package:flutter/material.dart';

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const FormInputComponent(
            label: 'Nome',
          ),
          const FormInputComponent(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const FormInputComponent(
            label: 'Dia Fechamento',
            keyboardType: TextInputType.number,
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
                MaterialPageRoute(builder: (context) => const SignIn())
              );
            },
            label: 'Cadastrar',
          ),
        ],
      ),
    );
  }
}