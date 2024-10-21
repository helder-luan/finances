import 'package:fingen/src/core/app_text.dart';
import 'package:fingen/src/ui/screens/Auth/SignIn/index.dart';
import 'package:fingen/src/ui/screens/Auth/SignUp/components/form_sign_up.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Column(
                    children: [
                      Text(
                        'Cadastrar',
                        style: AppTextStyles.title
                      ),
                      Text(
                        'Crie sua conta e aproveite',
                        style: AppTextStyles.subtitle
                      ),
                    ],
                  ),
                ),
                const FormSignUp(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ja tem uma conta? '),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      },
                      child: const Text(
                        'Entrar'
                      )
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}