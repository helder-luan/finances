import 'package:fingen/src/data/providers/contracts/login_provider.dart';
import 'package:fingen/src/data/providers/database_providers/login_firebase_provider.dart';

class LoginRepository {
  static final LoginProvider _loginProvider = LoginFirebaseProvider();

  Future<void> autenticar(String email, String senha) async {
    await _loginProvider.autenticar(email, senha);
  }
}