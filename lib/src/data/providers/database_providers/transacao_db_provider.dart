import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:finances/src/data/providers/contracts/transacao_provider.dart';

class TransacaoDbProvider extends TransacaoProvider {
  final sqlite.Database _database = Database.instance.getDB() as sqlite.Database;
  final String table = 'tbl_transacoes';
  
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
  Future<bool> delete(String id) async {
    await _database.delete(table, where: 'id = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    var id = registro['id'];
    registro.remove('id');
    await _database.update(table, registro, where: 'id = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByCard(String cardId) async {
    var result = await _database.query(table, where: 'idCartao = ?', whereArgs: [cardId]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDate(DateTime date) async {
    var result = await _database.query(table, where: 'dataCadastro = ?', whereArgs: [date]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateAndCard(DateTime date, String cardId) async {
    var result = await _database.query(table, where: 'dataCadastro = ? AND idCartao = ?', whereArgs: [date, cardId]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(DateTime startDate, DateTime endDate) async {
    var result = await _database.query(table, where: 'dataCadastro BETWEEN ? AND ?', whereArgs: [startDate, endDate]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRangeAndCard(DateTime startDate, DateTime endDate, String cardId) async {
    var result = await _database.query(table, where: 'dataCadastro BETWEEN ? AND ? AND idCartao = ?', whereArgs: [startDate, endDate, cardId]);

    return result.isNotEmpty ? result : [];
  }
}