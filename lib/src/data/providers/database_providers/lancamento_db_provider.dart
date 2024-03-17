import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finances/src/data/providers/contracts/lancamento_provider.dart';

class LancamentoDbProvider extends LancamentoProvider {
  final Database _database = DB.instance.databaseInstance;
  final String table = 'fnc_lancamento';
  
  @override
  Future<bool> insert(Map<String, dynamic> registro) async {
    registro.remove('idLancamento');
    await _database.insert(table, registro);

    return true;
  }

  @override
  Future<Map<String, dynamic>> recover(String id) async {
    var result = await _database.query(table, where: 'idLancamento = ?', whereArgs: [id]);

    return result.isNotEmpty ? result.first : {};
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    var result = await _database.query(table);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<bool> delete(String id) async {
    await _database.delete(table, where: 'idLancamento = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    var id = registro['idLancamento'];
    registro.remove('idLancamento');
    await _database.update(table, registro, where: 'idLancamento = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDate(DateTime date) async {
    var result = await _database.query(table, where: 'dataOcorrencia = ?', whereArgs: [date.toIso8601String()]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(DateTime startDate, DateTime endDate) async {
    var result = await _database.query(table, where: 'dataOcorrencia BETWEEN ? AND ?', whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByMonthReference(int monthReference) async {
    DateTime now = DateTime.now();

    var result = await _database.query(table, where: "dataOcorrencia BETWEEN ? AND ?", whereArgs: [DateTime(now.year, monthReference, 1).toIso8601String(), DateTime(now.year, monthReference + 1, 0).toIso8601String()]);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllGastoMensal() async {
    var result = await _database.query(table, where: 'recorrente = ? AND situacao = ?', whereArgs: ['S', 'A']);

    return result.isNotEmpty ? result : [];
  }
}