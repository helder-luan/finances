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
  Future<List<Map<String, dynamic>>> recoverAll() async {
    var result = await _database.query(table);

    return result;
  }
  
  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    await _database.update(
      table,
      registro,
      where: 'idFatura = ?',
      whereArgs: [registro['idFatura']]
    );

    return true;
  }

  @override
  Future<Map<String, dynamic>> recoverByCardId(String cardId) async {
    var result = await _database.query(
      table,
      where: 'idCartao = ?',
      whereArgs: [cardId]
    );

    return result.isNotEmpty ? result.first : {};
  }
  
  @override
  Future<Map<String, dynamic>> recoverByCardIdAndRefMonth(String cardId, String refMonth) async  {
    var result = await _database.query(
      table,
      where: 'idCartao = ? AND mesReferencia = ?',
      whereArgs: [cardId, refMonth]
    );

    return result.isNotEmpty ? result.first : {};
  }

  @override
  Future<void> updateByCardIdAndRefMonth(String cardId, String refMonth, String valorTotal) async {
    var result = await _database.query(
      table,
      where: 'idCartao = ? AND mesReferencia = ?',
      whereArgs: [cardId, refMonth]
    );

    if (result.isNotEmpty) {
      await _database.update(
        table,
        {'valorTotal': valorTotal},
        where: 'idCartao = ? AND mesReferencia = ?',
        whereArgs: [cardId, refMonth]
      );
    }
  }
}