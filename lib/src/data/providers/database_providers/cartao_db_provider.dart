import 'package:finances/src/data/providers/contracts/cartao_provider.dart';
import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqlite_api.dart';

class CartaoDbProvider extends CartaoProvider {
  final Database _database = DB.instance.databaseInstance;
  final String table = 'tbl_cartoes';

  @override
  Future<bool> insert(Map<String, dynamic> registro) async {
    registro.remove('id');
    await _database.insert(table, registro);

    return true;
  }
  
  @override
  Future<Map<String, dynamic>> recover(String id) async {
    var result = await _database.query(table, where: 'id = ?', whereArgs: [id]);
    
    return result.isNotEmpty ? result.first : {};
  }
  
  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    var result = await _database.query(table);

    return result.isNotEmpty ? result : [];
  }
  
  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    var id = registro['id'];
    registro.remove('id');
    await _database.update(table, registro, where: 'id = ?', whereArgs: [id]);

    return true;
  }
  
  @override
  Future<bool> delete(String id) async {
    await _database.delete(table, where: 'id = ?', whereArgs: [id]);
    return true;
  }
}