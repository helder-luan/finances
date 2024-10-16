import 'package:fingen/src/data/repositories/login_repository.dart';
import 'package:flutter/material.dart';

class AutenticacaoController extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  Future<bool> autenticar(String email, String senha) async {
    try {
      await _loginRepository.autenticar(email, senha);
      return true;
    } catch (e) {
      return false;
    }
  }
}