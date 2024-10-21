
import 'package:fingen/src/core/app_text.dart';
import 'package:fingen/src/ui/screens/Auth/SignIn/components/form_sign_in.dart';
import 'package:fingen/src/ui/screens/Auth/SignUp/index.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                        'Entrar',
                        style: AppTextStyles.title
                      ),
                      Text(
                        'Entre com seu email e senha',
                        style: AppTextStyles.subtitle
                      ),
                    ],
                  ),
                ),
                const FormSignIn(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não tem uma conta? '),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text(
                        'Criar conta'
                      )
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Esqueci a senha',
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}