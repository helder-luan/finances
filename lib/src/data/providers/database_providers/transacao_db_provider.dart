import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finances/src/data/providers/contracts/transacao_provider.dart';

class TransacaoDbProvider extends TransacaoProvider {
  final Database _database = DB.instance.databaseInstance;
  final String table = 'tbl_transacoes';
  
  @override
  Future<bool> insert(Map<String, dynamic> registro) async {
    registro.remove('idTransacao');
    await _database.insert(table, registro);

    return true;
  }

  @override
  Future<Map<String, dynamic>> recover(String id) async {
    var result = await _database.query(table, where: 'idTransacao = ?', whereArgs: [id]);

    return result.isNotEmpty ? result.first : {};
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    var result = await _database.query(table);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<bool> delete(String id) async {
    await _database.delete(table, where: 'idTransacao = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    var id = registro['idTransacao'];
    registro.remove('idTransacao');
    await _database.update(table, registro, where: 'idTransacao = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByCard(String cardId) async {
    var result = await _database.query(table, where: 'idCartao = ?', whereArgs: [cardId]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDate(String date) async {
    var result = await _database.query(table, where: 'dataCadastro = ?', whereArgs: [date]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateAndCard(String date, String cardId) async {
    var result = await _database.query(table, where: 'dataCadastro = ? AND idCartao = ?', whereArgs: [date, cardId]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(String startDate, String endDate) async {
    var result = await _database.query(table, where: 'dataCadastro BETWEEN ? AND ?', whereArgs: [startDate, endDate]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRangeAndCard(String startDate, String endDate, String cardId) async {
    var result = await _database.query(table, where: 'dataCadastro BETWEEN ? AND ? AND idCartao = ?', whereArgs: [startDate, endDate, cardId]);

    return result.isNotEmpty ? result : [];
  }
}