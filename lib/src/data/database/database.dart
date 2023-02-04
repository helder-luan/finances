import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart' as sqlite;

class Database {
  Database._();

  static final instance = Database._();

  static sqlite.Database? _database;

  Future getDB() async {
    if (_database != null) return _database;

    return await initDB();
  }

  Future<sqlite.Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'finances.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(db, version) async {
    await db.execute(_tipoCartao);
    await db.execute(_cartoes);
    await db.execute(_tipoOperacao);
    await db.execute(_transacoes);

    await db.insert('tbl_tipo_cartao', {'descricao': 'Crédito'});
    await db.insert('tbl_tipo_cartao', {'descricao': 'Débito'});

    await db.insert('tbl_tipo_operacao', {'descricao': 'Entrada'});
    await db.insert('tbl_tipo_operacao', {'descricao': 'Saida'});
  }

  String get _tipoCartao => '''
    CREATE TABLE tbl_tipo_cartao (
      idTipoCartao INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL
    );
  ''';

  String get _cartoes => '''
    CREATE TABLE tbl_cartoes (
      idCartao INTEGER PRIMARY KEY AUTOINCREMENT,
      idTipoCartao INTEGER NOT NULL,
      nome TEXT NOT NULL,
      finalCartao TEXT NOT NULL,
      diaVencimento INTEGER NOT NULL,
      hexCor TEXT NOT NULL,
      FOREIGN KEY (id_tipo_cartao) REFERENCES tbl_tipo_cartao (id)
    );
  ''';

  String get _tipoOperacao => '''
    CREATE TABLE tbl_tipo_operacao (
      idTipoOperacao INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL
    );
  ''';

  String get _transacoes => '''
    CREATE TABLE tbl_transacoes (
      idTransacao INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      valor TEXT NOT NULL,
      detalhes TEXT,
      dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
      idTipoOperacao INTEGER NOT NULL,
      reembolso BOOLEAN DEFAULT 0,
      idCartao INTEGER DEFAULT NULL,
      gastoMensal BOOLEAN DEFAULT 0,
      parcelado BOOLEAN DEFAULT 0,
      totalParcelas INTEGER DEFAULT 0,
      parcelaAtual INTEGER DEFAULT 0,
      FOREIGN KEY (idCartao) REFERENCES tbl_cartoes (idCartao),
      FOREIGN KEY (idTipoOperacao) REFERENCES tbl_tipo_operacao (idTipoOperacao)
    );
  ''';
}