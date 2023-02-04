import 'package:finances/src/data/models/transaction.dart';
import 'package:finances/src/data/providers/database_providers/transaction_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class TransactionRepository extends BaseRepository<Transaction> {
  TransactionRepository()
      : super(TransactionDbProvider(), (map) => Transaction.fromMap(map));
}
