import 'package:finances/src/data/providers/contracts/tipo_operacao_provider.dart';
import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

class TipoOperacaoDbProvider extends TipoOperacaoProvider {
  final sqlite.Database _database = Database.instance.getDB() as sqlite.Database;
  final String table = 'tbl_tipo_operacao';

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<bool> insert(Map<String, dynamic> registro) {
    // TODO: implement insert
    throw UnimplementedError();
  }
  
  @override
  Future<Map<String, dynamic>> recover(String id) {
    // TODO: implement recover
    throw UnimplementedError();
  }
  
  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    var result = await _database.query(table);

    return result;
  }
  
  @override
  Future<bool> update(Map<String, dynamic> registro) {
    // TODO: implement update
    throw UnimplementedError();
  }
}