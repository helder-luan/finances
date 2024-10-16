abstract class LoginProvider {
  Future<Map<String, dynamic>> autenticar(String email, String senha);
  Future<Map<String, dynamic>> cadastrar(String email, String senha);
  Future<void> recuperarSenha(String email);
}