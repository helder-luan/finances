abstract class CRUDProvider {
  Future<Map<String, dynamic>> insert(Map<String, dynamic> registro);
  Future<Map<String, dynamic>> update(Map<String, dynamic> registro);
  Future<Map<String, dynamic>> recover(String id);
  Future<List<Map<String, dynamic>>> recoverAll();
  Future<bool> delete(String id);
}
