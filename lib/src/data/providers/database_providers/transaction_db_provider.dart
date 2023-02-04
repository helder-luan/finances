import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:finances/src/data/providers/contracts/transaction_provider.dart';

class TransactionDbProvider extends TransactionProvider {
  final sqlite.Database _database = Database.instance.getDB() as sqlite.Database;
  final String table = 'tbl_transacoes';
  
  @override
  Future<bool> insert(Map<String, dynamic> registro) async {
    await _database.insert(table, registro);
    return true;
  }

  @override
  Future<Map<String, dynamic>> recover(String id) async {
    // TODO: implement recover
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    // TODO: implement recoverAll
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByCard(String cardId) async {
    // TODO: implement recoverAllByCard
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDate(DateTime date) async {
    // TODO: implement recoverAllByDate
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateAndCard(DateTime date, String cardId) async {
    // TODO: implement recoverAllByDateAndCard
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(DateTime startDate, DateTime endDate) async {
    // TODO: implement recoverAllByDateRange
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAllByDateRangeAndCard(DateTime startDate, DateTime endDate, String cardId) async {
    // TODO: implement recoverAllByDateRangeAndCard
    throw UnimplementedError();
  }
}