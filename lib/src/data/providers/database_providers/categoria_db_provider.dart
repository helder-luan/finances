import 'package:finances/src/data/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finances/src/data/providers/contracts/categoria_provider.dart';

class CategoriaDbProvider extends CategoriaProvider {
  final Database _database = DB.instance.databaseInstance;
  final String table = 'fnc_categoria';

  @override
  Future<bool> insert(Map<String, dynamic> registro) async {
    registro.remove('idCategoria');
    await _database.insert(table, registro);

    return true;
  }

  @override
  Future<Map<String, dynamic>> recover(String id) async {
    var result = await _database.query(table, where: 'idCategoria = ?', whereArgs: [id]);

    return result.isNotEmpty ? result.first : {};
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    var result = await _database.query(table);

    return result.isNotEmpty ? result : [];
  }

  @override
  Future<bool> delete(String id) async {
    await _database.delete(table, where: 'idCategoria = ?', whereArgs: [id]);

    return true;
  }

  @override
  Future<bool> update(Map<String, dynamic> registro) async {
    var id = registro['idCategoria'];
    registro.remove('idCategoria');
    await _database.update(table, registro, where: 'idCategoria = ?', whereArgs: [id]);

    return true;
  }
}