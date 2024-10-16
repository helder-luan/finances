import 'package:fingen/src/ui/components/Button/index.dart';
import 'package:fingen/src/ui/components/Form/Input/index.dart';
import 'package:flutter/material.dart';

class Autenticacao extends StatefulWidget {
  const Autenticacao({super.key});

  @override
  State<Autenticacao> createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Autenticação',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text('Entre com seu email e senha'),
              const SizedBox(height: 40),
              const FormInputComponent(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const FormInputComponent(
                label: 'Senha',
                isPassword: true,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonComponent(
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Esqueci a senha',
                  style: TextStyle(
                    decoration: TextDecoration.underline
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não tenha conta?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(
                        decoration: TextDecoration.underline
                      )
                    )
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}