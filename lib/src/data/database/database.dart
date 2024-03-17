import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
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
      version: int.tryParse(dotenv.env['DB_VERSION']!),
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

    if (!kReleaseMode) {
      await db.rawInsert('''
        INSERT INTO fnc_lancamento (descricao, detalhes, valor, dataOcorrencia, tipo, recorrente, parcelado, situacao)
        VALUES 
          ('Salário', 'Pagamento mensal', 3000.00, '2024-03-01', 'R', 'N', 'N', 'A'),
          ('Mercado', 'Compras do mês', 250.00, '2024-03-05', 'D', 'N', 'N', 'A'),
          ('Transporte', 'Recarga de passe mensal', 50.00, '2024-03-10', 'D', 'N', 'N', 'A'),
          ('Restaurante', 'Almoço com amigos', 80.00, '2024-03-18', 'D', 'N', 'N', 'A'),
          ('Educação', 'Mensalidade escolar', 500.00, '2024-03-20', 'D', 'N', 'N', 'A'),
          ('Freelance', 'Projeto de design', 800.00, '2024-03-25', 'R', 'N', 'N', 'A'),
          ('Luz', 'Pagamento da conta de luz', 100.00, '2024-03-28', 'D', 'N', 'N', 'A'),
          ('Internet', 'Pagamento da internet', 80.00, '2024-03-30', 'D', 'S', 'N', 'A'),
          ('Presente', 'Presente para aniversário', 50.00, '2024-03-05', 'D', 'N', 'N', 'A'),
          ('Cinema', 'Ida ao cinema', 20.00, '2024-03-07', 'D', 'N', 'N', 'A'),
          ('Livros', 'Compra de livros', 40.00, '2024-03-12', 'D', 'N', 'N', 'A'),
          ('Telefone', 'Pagamento da conta de telefone', 60.00, '2024-03-16', 'D', 'S', 'N', 'A'),
          ('Viagem', 'Passagens para viagem', 300.00, '2024-03-22', 'D', 'N', 'N', 'A'),
          ('Gás', 'Pagamento do botijão de gás', 70.00, '2024-03-24', 'D', 'N', 'N', 'A'),
          ('Academia', 'Mensalidade da academia', 80.00, '2024-03-10', 'D', 'N', 'N', 'A'),
          ('Consultoria', 'Consultoria em marketing', 600.00, '2024-03-14', 'R', 'N', 'N', 'A'),
          ('Seguro', 'Pagamento do seguro do carro', 150.00, '2024-03-19', 'D', 'N', 'N', 'A'),
          ('Roupas', 'Compra de roupas', 100.00, '2024-03-28', 'D', 'N', 'N', 'A'),
          -- Lançamentos Parcelados
          ('1/3 - Compra parcelada', 'Compra parcelada em 3 vezes', 120.00, '2024-03-05', 'D', 'N', 'S', 'A'),
          ('2/3 - Compra parcelada', 'Compra parcelada em 3 vezes', 120.00, '2024-04-05', 'D', 'N', 'S', 'A'),
          ('3/3 - Compra parcelada', 'Compra parcelada em 3 vezes', 120.00, '2024-05-05', 'D', 'N', 'S', 'A'),
          -- Lançamentos Recorrentes
          ('Aluguel', 'Pagamento do aluguel', 1200.00, '2024-03-15', 'D', 'S', 'N', 'A');
      ''');
    }
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
      parcelado TEXT DEFAULT 'N',
      situacao TEXT DEFAULT 'A',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (idCategoria) REFERENCES tbl_categorias (idCategoria)
    )
  ''';
}