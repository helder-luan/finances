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
    await db.execute(_categoria);
    await db.execute(_lancamento);

    await db.rawInsert('''
      INSERT INTO fnc_categoria (descricao, situacao) VALUES
        ('Lazer', 'A'),
        ('Alimentação', 'A'),
        ('Transporte', 'A'),
        ('Saúde', 'A'),
        ('Educação', 'A'),
        ('Moradia', 'A'),
        ('Vestuário', 'A'),
        ('Outros', 'A'),
        ('Salário', 'A'),
        ('Investimento', 'A'),
        ('Presente', 'A'),
        ('Empréstimo', 'A')
    ''');
  }

  String get _categoria => '''
    CREATE TABLE fnc_categoria (
      idCategoria INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      situacao TEXT DEFAULT 'A'
    )
  ''';

  String get _lancamento => '''
    CREATE TABLE fnc_lancamento (
      idLancamento INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT NOT NULL,
      detalhes TEXT,
      idCategoria INTEGER,
      valor REAL NOT NULL,
      dataOcorrencia DATE NOT NULL,
      tipo TEXT NOT NULL,
      recorrente TEXT DEFAULT 'N',
      situacao TEXT DEFAULT 'A',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (idCategoria) REFERENCES tbl_categorias (idCategoria)
    )
  ''';
}