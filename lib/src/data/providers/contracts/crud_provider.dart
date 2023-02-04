abstract class CRUDProvider {
  Future<bool> insert(Map<String, dynamic> registro);
  Future<bool> update(Map<String, dynamic> registro);
  Future<Map<String, dynamic>> recover(String id);
  Future<List<Map<String, dynamic>>> recoverAll();
  Future<bool> delete(String id);
}
