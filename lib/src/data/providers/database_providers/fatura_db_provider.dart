import 'package:finances/src/data/database/database.dart';
import 'package:finances/src/data/providers/contracts/fatura_provider.dart';
import 'package:sqflite/sqflite.dart';

class FaturaDbProvider extends FaturaProvider {
  final Database _database = DB.instance.databaseInstance;
  final String table = 'tbl_faturas';
  
  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<bool> insert(Map<String, dynamic> registro) async {
    registro.remove('idFatura');
    await _database.insert(table, registro);

    return true;
  }
  
  @override
  Future<Map<String, dynamic>> recover(String id) {
    // TODO: implement recover
    throw UnimplementedError();
  }
  
  @override
  Future<List<Map<String, dynamic>>> recoverAll() {
    // TODO: implement recoverAll
    throw UnimplementedError();
  }
  
  @override
  Future<bool> update(Map<String, dynamic> registro) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<Map<String, dynamic>> recoverByCardId(String cardId) async {
    var result = await _database.query(table, where: 'idCartao = ?', whereArgs: [cardId]);
    
    return result.isNotEmpty ? result.first : {};
  }
}