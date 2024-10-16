import 'package:firebase_auth/firebase_auth.dart';

class SignInTraitErrors {
  final FirebaseAuthException? exception;

  static final _traits = {
    'invalid-email': 'Email inválido',
    'invalid-password': 'Senha inválida',
    'email-already-exists': 'Email já está em uso',
    'user-not-found': 'Usuário não encontrado',
    'wrong-password': 'Senha incorreta',
  };

  SignInTraitErrors({
    this.exception
  });

  static String getError({required FirebaseAuthException exception}) {
    return _traits[exception.code] ?? 'Algo errado aconteceu. Tente novamente em breve.';
  }
}