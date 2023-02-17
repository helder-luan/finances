import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB _db = DB._();
  DB._();

  static DB get instance => _db;
  static late Database _database;

  get databaseInstance => _database;

  Future<void> initDB() async {
    final String path = join(await getDatabasesPath(), 'finances.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }

  Future _onCreate(db, version) async {
    await db.execute(_tipoCartao);
    await db.execute(_cartoes);
    await db.execute(_tipoOperacao);
    await db.execute(_transacoes);
    await db.execute(_faturas);

    await db.insert('tbl_tipo_cartao', {'descricao': 'Crédito'});
    await db.insert('tbl_tipo_cartao', {'descricao': 'Débito'});
    await db.insert('tbl_tipo_cartao', {'descricao': 'Ambos'});

    await db.insert('tbl_tipo_operacao', {'descricao': 'Entrada'});
    await db.insert('tbl_tipo_operacao', {'descricao': 'Saída'});
  }
  
  String get _tipoCartao => '''
    CREATE TABLE tbl_tipo_cartao (
      idTipoCartao INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL
    )
  ''';

  String get _tipoOperacao => '''
    CREATE TABLE tbl_tipo_operacao (
      idTipoOperacao INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL
    )
  ''';

  String get _cartoes => '''
    CREATE TABLE tbl_cartoes (
      idCartao INTEGER PRIMARY KEY AUTOINCREMENT,
      idTipoCartao INTEGER NOT NULL,
      nome TEXT NOT NULL,
      finalCartao TEXT NOT NULL,
      diaVencimento INTEGER NOT NULL,
      hexCor TEXT NOT NULL,
      FOREIGN KEY (idTipoCartao) REFERENCES tbl_tipo_cartao (idTipoCartao)
    )
  ''';

  String get _transacoes => '''
    CREATE TABLE tbl_transacoes (
      idTransacao INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      valor TEXT NOT NULL,
      detalhes TEXT,
      dataCadastro TEXT NOT NULL,
      idTipoOperacao INTEGER NOT NULL,
      mesReferencia INTEGER,
      reembolso BOOLEAN DEFAULT 0,
      idCartao INTEGER DEFAULT NULL,
      gastoMensal BOOLEAN DEFAULT 0,
      parcelado BOOLEAN DEFAULT 0,
      totalParcelas INTEGER DEFAULT 0,
      parcelaAtual INTEGER DEFAULT 0,
      FOREIGN KEY (idCartao) REFERENCES tbl_cartoes (idCartao),
      FOREIGN KEY (idTipoOperacao) REFERENCES tbl_tipo_operacao (idTipoOperacao)
    )
  ''';

  String get _faturas => '''
    CREATE TABLE tbl_faturas (
      idFatura INTEGER PRIMARY KEY AUTOINCREMENT,
      idCartao INTEGER NOT NULL,
      mesReferencia INTEGER NOT NULL,
      dataFechamento TEXT NOT NULL,
      dataVencimento TEXT NOT NULL,
      dataPagamento TEXT NOT NULL,
      valorTotal TEXT NOT NULL,
      valorPago TEXT NOT NULL,
      FOREIGN KEY (idCartao) REFERENCES tbl_cartoes (idCartao)
    )
  ''';
}