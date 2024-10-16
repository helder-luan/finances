import 'package:fingen/src/data/providers/contracts/login_provider.dart';
import 'package:fingen/src/data/trait-exceptions/sign_in_trait_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginFirebaseProvider extends LoginProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Map<String, dynamic>> autenticar(String email, String senha) async {
    try {
      final UserCredential dadosAutenticacao = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
      
      return {
        'id': dadosAutenticacao.user?.uid,
        'email': dadosAutenticacao.user?.email
      };
    } on FirebaseAuthException catch (e) {
      throw SignInTraitErrors.getError(exception: e);
    }
  }

  @override
  Future<Map<String, dynamic>> cadastrar(String email, String senha) {
    // TODO: implement cadastrar
    throw UnimplementedError();
  }

  @override
  Future<void> recuperarSenha(String email) {
    // TODO: implement recuperarSenha
    throw UnimplementedError();
  }
}